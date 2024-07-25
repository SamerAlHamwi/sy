

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sy/screens/home/home.dart';
import 'package:sy/screens/login/login_page.dart';
import 'package:sy/screens/password/password_screen.dart';
import 'package:sy/screens/settings/settings.dart';
import 'package:sy/utils/keys.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  AudioPlayer.global.setAudioContext(AudioContextConfig(/*...*/).build());
  await SettingsData.init();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Keys.navigatorKey,
      title: 'Ecsc.sy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ), // Shape
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
        ),
      ),
      //home: const PasswordScreen(),
      home: SettingsData.hasToken() ? const HomeScreen(isWithUpdate: true,) : const LoginScreen(),
    );
  }
}

