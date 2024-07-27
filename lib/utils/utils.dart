

import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sy/models/alias_enum.dart';
import 'package:sy/models/process_model.dart';
import 'package:sy/screens/add_process/models/add_process_model.dart';
import 'package:sy/screens/settings/settings.dart';
import 'package:sy/utils/dio_client.dart';
import 'package:sy/utils/keys.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Utils {

  static getHeaders(AliasEnum type){
    String session = SettingsData.getSession;
    String alias;
    switch(type){

      case AliasEnum.add:
        alias = 'OPHRUHvKso';
      case AliasEnum.delete:
        alias = 'OPMEShwoqV';
      case AliasEnum.getAll:
        alias = 'OPkUVkYsyq';
      case AliasEnum.reserve:
        alias = '';
      case AliasEnum.details:
        alias = 'OPSfpsWfkvps';
      case AliasEnum.none:
        alias = '';

      //OPSyGCrxPB notifications
    }

    final Map<String,dynamic> headers = {
      'Content-Type': 'application/json'
    };

    // if(!SettingsData.getType){
      headers.addAll({
        'Accept': 'application/json, text/plain, */*',
        'Accept-Encoding': 'gzip, deflate, br, zstd',
        'Accept-Language': 'en-US,en;q=0.9,ar;q=0.8',
        'Connection': 'keep-alive',
        'Cache-Control': 'max-age=0',
        'Host': 'api.ecsc.gov.sy:8080',
        'Referer': 'https://www.ecsc.gov.sy/',
        'Origin': 'https://www.ecsc.gov.sy',
        'Sec-Ch-Ua': '"Not/A)Brand";v="8", "Chromium";v="126", "Microsoft Edge";v="126"',
        'Sec-Ch-Ua-Mobile': '?0',
        'Sec-Ch-Ua-Platform': 'Windows',
        'Sec-Fetch-Dest': 'empty',
        'Sec-Fetch-Mode': 'cors',
        'Sec-Fetch-Site': 'same-site',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:128.0) Gecko/20100101 Firefox/128.0',
        'Source': 'WEB',
      });
    //As Edge
    //'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0',
    // }else{
    //   headers.addAll({
    //     'Source': 'API',
    //     'Version': 2,
    //     'Authorization': session,
    //   });
    // }

    if(alias.isNotEmpty){
      headers.addAll({
        'Alias': alias,
      });
    }

    if(session.isNotEmpty){ // && !SettingsData.getType
      headers.addAll({
        'Cookie': 'SESSION=$session',
      });
    }

    return headers;
  }


  static saveImageToDevice(Uint8List imageBytes,String imageName) async {
    try {
      final directory = await getDownloadsDirectory();

      if (directory == null) {
        return;
      }

      final imagePath = '${directory.path}/$imageName.jpg';

      final file = File(imagePath);

      if (await file.exists()) {
        print('exist');
      }
      else {
        await file.writeAsBytes(imageBytes);
        print('Image saved');
      }
    } catch (e) {
      print('Error saving image');
    }
  }


  static getOptions(AliasEnum type){
    return Options(
      headers: getHeaders(type),
      sendTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 90),
      persistentConnection: true,
      followRedirects: true,
    );
  }


  static getMyProcesses() async {
    const getTransactionsUrl = 'https://api.ecsc.gov.sy:8080/dbm/db/execute';

    final Dio dio = DioClient.getDio();

    try {
      final response = await dio.post(
          getTransactionsUrl,
          options: Utils.getOptions(AliasEnum.getAll),
          data: {
            "ALIAS": "OPkUVkYsyq",
            "P_USERNAME": "WebSite",
            "P_PAGE_INDEX": 0,
            "P_PAGE_SIZE": 100
          }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        SettingsData.setMyProcesses(data);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = e.response?.data['Message'] ?? 'An unexpected error occurred.';

      showTopSnackBar(
        Overlay.of(Keys.overlayKey.currentState!.context),
        CustomSnackBar.error(
          message: errorMessage,
        ),
      );
      return false;
    } catch (e) {
      return false;
    }
  }

  static addProcess(Map model) async {
    const addTransactionsUrl = 'https://api.ecsc.gov.sy:8080/dbm/db/execute';

    final Dio dio = DioClient.getDio();

    try {
      final response = await dio.post(
        addTransactionsUrl,
        options: Utils.getOptions(AliasEnum.add),
        data: model,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        showTopSnackBar(
          Overlay.of(Keys.overlayKey.currentState!.context),
          CustomSnackBar.success(
            message: 'تمت إضافة المعاملة بنجاح',
          ),
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = e.response?.data['Message'] ?? 'An unexpected error occurred.';

      showTopSnackBar(
        Overlay.of(Keys.overlayProcessKey.currentState!.context),
        CustomSnackBar.error(
          message: errorMessage,
        ),
      );

      return false;
    } catch (e) {
      return false;
    }
  }

  static deleteProcess(int id) async {
    const getTransactionsUrl = 'https://api.ecsc.gov.sy:8080/dbm/db/execute';

    final Dio dio = DioClient.getDio();

    try {
      final response = await dio.post(
          getTransactionsUrl,
          options: Utils.getOptions(AliasEnum.delete),
          data: {
            "ALIAS": "OPMEShwoqV",
            "P_USERNAME": "WebSite",
            "P_ID": id
          }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        showTopSnackBar(
          Overlay.of(Keys.overlayKey.currentState!.context),
          CustomSnackBar.success(
            message: 'تم حذف المعاملة بنجاح',
          ),
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = e.response?.data['Message'] ?? 'An unexpected error occurred.';

      showTopSnackBar(
        Overlay.of(Keys.overlayKey.currentState!.context),
        CustomSnackBar.error(
          message: errorMessage,
        ),
      );
      return false;
    } catch (e) {
      return false;
    }
  }




  static playAudio(AudioPlayer player,String audio) async {
    await player.play(AssetSource(audio));
  }


}

