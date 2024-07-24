


import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sy/models/alias_enum.dart';
import 'package:sy/models/login_model.dart';
import 'package:sy/models/process_model.dart';
import 'package:sy/screens/home/home.dart';
import 'package:sy/screens/settings/settings.dart';
import 'package:sy/utils/utils.dart';
import 'package:sy/widgets/custom_textfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

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
              controller: numberController,
              hint: 'رقم الهاتف',
              onChanged: (String? value) {

              },
            ),
          ),
          const SizedBox(
            height: 20,
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
              bool success = await login(userName: numberController.text, password: passwordController.text);
              if(success){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
              }
            },
            child: _isLoading ? const Text('يتم التحميل...') : const Text('تسجيل الدخول'),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Web'
              ),
              const SizedBox(width: 8,),
              Switch(
                  value: SettingsData.getType,
                  activeColor: Colors.blueAccent,
                  onChanged: (bool value){
                    setState(() {
                      SettingsData.setType(value);
                    });
                  },
              ),
              const SizedBox(width: 8,),
              const Text(
                  'Mobile'
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<bool> login({required String userName,required String password}) async {
    setState(() {
      _isLoading = true;
    });

    const loginUrl = 'https://api.ecsc.gov.sy:8080/secure/auth/login';

    final dio = Dio();

    try {
      final response = await dio.post(
          loginUrl,
          options: Utils.getOptions(AliasEnum.none),
          data: {
            'username': userName, 'password': password
          }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        if(SettingsData.getType){
          String session = response.headers['authorization']?.first as String;
          SettingsData.setSession(session);
          LoginModel model = LoginModel.fromJson(data);
          SettingsData.setUser(data);
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: 'مرحباً ${model.pPROFILERESULT!.fULLNAME} تم تسجيل الدخول بنجاح، جاري تحضير المعاملات ',
            ),
          );
        }
        else{
          String session = response.headers['set-cookie']?.first as String;
          RegExp regExp = RegExp(r'SESSION=([^;]+)');
          Match? match = regExp.firstMatch(session);
          if (match != null) {
            String sessionValue = match.group(1)!;
            SettingsData.setSession(sessionValue);
            LoginModel model = LoginModel.fromJson(data);
            SettingsData.setUser(data);
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                message: 'مرحباً ${model.pPROFILERESULT!.fULLNAME} تم تسجيل الدخول بنجاح، جاري تحضير المعاملات ',
              ),
            );
          }
        }

        setState(() {});
        bool isSuccess = await Utils.getMyProcesses();

        return isSuccess;
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
      String errorMessage = e.response?.data['Message'] ?? 'An unexpected error occurred.';

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: errorMessage,
        ),
      );
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
        _isLoading = false;
      });
    }
  }


  getTransactionsNumbers() async {

    const getTransactionsUrl = 'https://api.ecsc.gov.sy:8080/dbm/db/execute';

    final dio = Dio();

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
        ProcessModel model = ProcessModel.fromJson(data);


        // SettingsData.setSession(sessionValue);

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
      String errorMessage = e.response?.data['Message'] ?? 'An unexpected error occurred.';

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: errorMessage,
        ),
      );
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
        _isLoading = false;
      });
    }
  }
}
