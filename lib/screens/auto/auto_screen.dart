

import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sy/constants/constans.dart';
import 'package:sy/screens/settings/settings.dart';
import 'package:sy/utils/dio_client.dart';
import 'package:sy/utils/utils.dart';
import 'package:sy/widgets/clock_widget.dart';
import 'package:sy/widgets/custom_textfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/alias_enum.dart';


class AutoPage extends StatefulWidget {
  const AutoPage({super.key});

  @override
  _AutoPageState createState() => _AutoPageState();
}


class _AutoPageState extends State<AutoPage> with AutomaticKeepAliveClientMixin {


  Uint8List? _imageBytes;
  bool isSwitchOn = false;
  var player = AudioPlayer();
  List<String> times = [];

  final TextEditingController solveController = TextEditingController();
  final TextEditingController speedController = TextEditingController();


  @override
  void dispose() {
    solveController.dispose();
    speedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.of(context).size.width;


    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      )
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const StreamClockWidget(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CustomTextField(
                  controller: speedController,
                  hint: 'سرعة النقار',
                  onChanged: (value){

                  },
                ),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: (){
                  if(!isSwitchOn){
                    _toggleSwitch();
                  }
                },
                onLongPress: (){
                  setState(() {
                    isSwitchOn = !isSwitchOn;
                    times.clear();
                  });
                },
                child: Text(
                    isSwitchOn ? 'النقار يعمل' : 'تشغيل النقار'
                ),
              ),

              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 400,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: ListView(
                    reverse: true,
                    children: List.generate(times.length, (index) => Text(times[index])),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  void _toggleSwitch() async {
    if(speedController.text.isNotEmpty){
      setState(() {
        isSwitchOn = !isSwitchOn;
      });
      for(int i = 0;i < 10000; i++){
        if(!isSwitchOn){
          break;
        }
        bool result = await getCaptcha(int.parse(SettingsData.getId1));
        // if(!result){
        //   setState(() {
        //     isSwitchOn = !isSwitchOn;
        //   });
        //   break;
        // }
        await Future.delayed(Duration(milliseconds: int.parse(speedController.text.trim())));
      }
    }else{
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'الرجاء تحديد سرعة النقار',
        ),
      );
    }
  }


  Future<bool> getCaptcha(int id) async {

    final captchaUrl = 'https://api.ecsc.gov.sy:8080/files/fs/captcha/$id';

    final Dio dio = DioClient.getDio();

    try{
      final response = await dio.get(captchaUrl,options: Utils.getOptions(AliasEnum.none));

      if(response.statusCode == 200){

        final Map<String, dynamic> data = response.data;
        final String imageUrl = data['file'];

        _imageBytes = base64Decode(imageUrl);

        setState(() {});
        return true;
      }
      return true;
    } on DioException catch (e) {

      String errorMessage = e.response?.data['Message'] ?? 'An unexpected error occurred.';
      print(errorMessage);

      if (errorMessage.contains('معالجة') || errorMessage.contains('تجاوزت')){
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            message: errorMessage,
          ),
        );
        if(!(player.state == PlayerState.playing)){
          Utils.playAudio(player,alertSound);
        }
        DateTime now = DateTime.now();
        DateTime now2 = DateTime.now().add(const Duration(seconds: 18));
        setState(() {
          times.add('${now.hour}:${now.minute}:${now.second} = ${now2.hour}:${now2.minute}:${now2.second}');
        });
        return false;
      }
      return true;
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Code Error',
        ),
      );
      return true;
    }
  }


  @override
  bool get wantKeepAlive => true;

}
