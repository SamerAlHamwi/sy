


import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:sy/models/login_model.dart';
import 'package:sy/models/process_model.dart';

class SettingsData {

  static String storageName = 'sy';
  static GetStorage box = GetStorage(storageName);
  static String tokenKey = 'session';
  static String processKey = 'process';
  static String userKey = 'user';
  static String typeKey = 'type';

  static String session = '', alias = '';

  static init() async {
    await GetStorage.init(storageName);
  }

  static hasToken() {
    if (box.hasData(tokenKey)) {
      return true;
    } else {
      return false;
    }
  }


  static setMyProcesses(Map model){
    box.write(processKey, model);
  }

  static setUser(Map model){
    box.write(userKey, model);
  }

  static setSession(String userSession){
    box.write(tokenKey, userSession);
  }

  static setType(bool isMobile){
    box.write(typeKey, isMobile);
  }

  static logout() async {
    await box.remove(tokenKey);
  }



  static String get getSession => box.read(tokenKey) ?? '';
  static String get getAlias => '';
  static bool get getType => box.read(typeKey) ?? false;
  static String get getId1 => getProcesses!.pRESULT!.isNotEmpty ? getProcesses!.pRESULT![0].pROCESSID.toString() : "";
  static String get getId2 => getProcesses!.pRESULT!.length > 1 ? getProcesses!.pRESULT![1].pROCESSID.toString() : "";
  static ProcessModel? get getProcesses {
    return ProcessModel.fromJson(box.read(processKey));
  }

  static LoginModel? get getUser {
    return LoginModel.fromJson(box.read(userKey));
  }

}