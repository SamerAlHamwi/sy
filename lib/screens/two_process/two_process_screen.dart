

import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sy/constants/constans.dart';
import 'package:sy/screens/settings/settings.dart';
import 'package:sy/utils/utils.dart';
import 'package:sy/widgets/clock_widget.dart';
import 'package:sy/widgets/custom_textfield.dart';
import 'package:sy/widgets/numbers_keyboard.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/alias_enum.dart';
import '../../widgets/equation_widget.dart';
import '../../widgets/no_equation_widget.dart';

class TwoWorkPage extends StatefulWidget {
  const TwoWorkPage({super.key});

  @override
  _TwoWorkPageState createState() => _TwoWorkPageState();
}

class _TwoWorkPageState extends State<TwoWorkPage> with AutomaticKeepAliveClientMixin {
  Uint8List? imageBytes;
  Uint8List? imageBytes2;
  final TextEditingController solveController = TextEditingController();
  final TextEditingController solveController2 = TextEditingController();
  bool isLoading = false;

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
            const SizedBox(height: 10,),
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
            imageBytes != null
                ? EquationWidget(imageBytes: imageBytes!,)
                : const NoEquationWidget(isForOne: true,),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.22,
                    child: CustomTextField(
                      controller: solveController,
                      readOnly: true,
                      hint: 'المعادلة1',
                      onChanged: (String? value) {  },
                    ),
                  ),
                  const StreamClockWidget(),
                  TextButton(
                    onPressed: (){
                      getCaptcha(int.parse(SettingsData.getId1));
                      getCaptcha(int.parse(SettingsData.getId2));
                    },
                    child: isLoading
                        ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Loading...'),
                      ],
                    )
                        : const Text('معادلتين'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(solveController.text.isNotEmpty){
                        reservePassport(int.parse(SettingsData.getId1), int.parse(solveController.text));
                        solveController.clear();
                      }
                    },
                    child: const Text('تثبيت1'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            CustomNumberKeyboard(
              onBackspaceTap: (){
                if(solveController.text.isNotEmpty){
                  solveController.text = solveController.text.substring(0, solveController.text.length - 1);
                }
              },
              onKeyTap: (value){
                if(solveController.text.length < 4){
                  solveController.text = '${solveController.text}$value';
                }
              },
              onReserveTap: (){
                if(solveController.text.isNotEmpty){
                  reservePassport(int.parse(SettingsData.getId1), int.parse(solveController.text));
                  solveController.clear();
                }
              },
            ),
            const SizedBox(height: 10,),
            imageBytes2 != null
                ? EquationWidget(imageBytes: imageBytes2!,)
                : const NoEquationWidget(isForOne: false,),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.22,
                    child: CustomTextField(
                      controller: solveController2,
                      readOnly: true,
                      hint: 'المعادلة2',
                      onChanged: (String? value) {  },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(solveController2.text.isNotEmpty){
                        reservePassport(int.parse(SettingsData.getId1), int.parse(solveController2.text));
                        solveController2.clear();
                      }
                    },
                    child: const Text('تثبيت2'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            CustomNumberKeyboard(
              onBackspaceTap: (){
                if(solveController2.text.isNotEmpty){
                  solveController2.text = solveController2.text.substring(0, solveController2.text.length - 1);
                }
              },
              onKeyTap: (value){
                if(solveController2.text.length < 4){
                  solveController2.text = '${solveController2.text}$value';
                }
              },
              onReserveTap: (){
                if(solveController2.text.isNotEmpty){
                  reservePassport(int.parse(SettingsData.getId2), int.parse(solveController2.text));
                  solveController2.clear();
                }
              },
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Future<bool> getCaptcha(int id) async {
    setState(() {
      isLoading = true;
    });

    final captchaUrl = 'https://api.ecsc.gov.sy:8080/files/fs/captcha/$id';

    final dio = Dio();

    try {
      final response = await dio.get(captchaUrl, options: Utils.getOptions(AliasEnum.none));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final String imageUrl = data['file'];
        imageBytes = base64Decode(imageUrl);
        setState(() {});

        return true;
      } else {
        final responseBody = json.decode(response.data);
        final message = responseBody['Message'];
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: message,
          ),
        );
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = e.response?.data['Message'] ?? 'حدث خطأ اثناء طلب المعادلة';

      if(errorMessage.contains('تجاوزت') || errorMessage.contains('معالجة')){
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            message: errorMessage,
          ),
        );
        Utils.playAudio(AudioPlayer(),alertSound);
      }else{
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: errorMessage,
          ),
        );
      }
      return false;
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'An unexpected error occurred. Please try again.',
        ),
      );
      return false;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> reservePassport(int id, int captcha) async {
    final reserveUrl = 'https://api.ecsc.gov.sy:8080/rs/reserve?id=$id&captcha=$captcha';
    final dio = Dio();

    for(int i = 0;i < 5;i++){
      try {
        final response = await dio.get(reserveUrl, options: Utils.getOptions(AliasEnum.reserve));

        if (response.statusCode == 200) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: "تم تثبيت المعاملة بنجاح",
            ),
          );
          break;
        }
      } on DioException catch (e) {
        String errorMessage = e.response?.data['Message'] ?? 'An unexpected error occurred.';

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: errorMessage,
          ),
        );
        if(errorMessage.contains('نأسف') || errorMessage.contains('النتيجة')){
          break;
        }
      } catch (e) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'An unexpected error occurred. Please try again.',
          ),
        );
      }
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  bool get wantKeepAlive => true;
}

