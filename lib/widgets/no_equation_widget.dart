

import 'package:flutter/material.dart';

import '../screens/settings/settings.dart';


class NoEquationWidget extends StatelessWidget {
  const NoEquationWidget({super.key, required this.isForOne});

  final bool isForOne;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Text(
          isForOne ? SettingsData.getId1 : SettingsData.getId2,
        ),
      ),
    );
  }
}
