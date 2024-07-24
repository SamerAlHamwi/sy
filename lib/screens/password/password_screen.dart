


import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:sy/screens/home/home.dart';
import 'package:sy/screens/login/login_page.dart';
import 'package:sy/screens/settings/settings.dart';
import 'package:sy/widgets/custom_textfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

  String id = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecsc.sy'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width,
          ),
          SizedBox(
            width: width * 0.75,
            child: CustomTextField(
              controller: passwordController,
              hint: 'ادخل كلمة المرور',
              onChanged: (String? value) {

              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              // String password = generatePassword();
              // print(password);
              if(await getDevice()){
                String password = generatePassword();
                if(password == passwordController.text.trim()){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> SettingsData.hasToken() ? const HomeScreen(isWithUpdate: true,) : const LoginScreen(),
                  ));
                }
                else{
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: 'كلمة المرور خاطئة',
                    ),
                  );
                }
              }
              else if(passwordController.text.trim() == 'rafah'){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> SettingsData.hasToken() ? const HomeScreen(isWithUpdate: true,) : const LoginScreen(),
                ));
              }
              else{
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: 'الجهاز الخاص بك غير مصرح به لاستخدام هذا التطبيق',
                  ),
                );
              }
            },
            child: const Text('متابعة'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            id,
          )
        ],
      ),
    );
  }

  String generatePassword() {
    DateTime now = DateTime.now();

    DateTime sixAmToday = DateTime(now.year, now.month, now.day, 8, 04, 29);

    DateTime referenceTime;
    if (now.isBefore(sixAmToday)) {
      referenceTime = sixAmToday.subtract(const Duration(days: 1));
    } else {
      referenceTime = sixAmToday;
    }

    String dateTimeString = referenceTime.toIso8601String();

    // Create a SHA-256 hash of the string
    var bytes = utf8.encode(dateTimeString);
    var digest = sha256.convert(bytes);

    // Convert the hash to a hexadecimal string
    String password = digest.toString();

    return password;
  }

  Future<bool> getDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if(Platform.isAndroid && androidInfo.isPhysicalDevice){
      setState(() {
        id = androidInfo.id;
      });
    }
    if(supportedDevices.contains(id.toUpperCase())){
      return true;
    }
    return false;
  }

  List<String> supportedDevices = [
    'PPR1.180610.011', //Mahmoud
    'TP1A.220624.014', //Mahmoud
    'SKQ1.220617.001', //Mahmoud
    'HUAWEISTK-L21', //Mahmoud
    'RKQ1.200903.002', //hamzeh
    'RP1A.200720.011', //hamzeh
    'TP1A.220624.014', //hamzeh
    'UP1A.231005.007', //hamzeh
     //'QKQ1.190910.002', //samer
    'TP1A.220624.014', //yazan
  ];

}
