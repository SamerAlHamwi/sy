

import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyTap;
  final VoidCallback onBackspaceTap;
  final VoidCallback onReserveTap;

  const CustomKeyboard({super.key,
    required this.onKeyTap,
    required this.onBackspaceTap,
    required this.onReserveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[

          _buildNumberKey('تثبيت',250,context),

          Column(
            children: [
              _buildNumberRow(['1', '2', '3'],context),
              _buildNumberRow(['4', '5', '6'],context),
              _buildNumberRow(['7', '8', '9'],context),
              _buildNumberRow(['0', '⌫'],context),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> values,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values.map((value) {
        return _buildNumberKey(value, null,context);
      }).toList(),
    );
  }

  Widget _buildNumberKey(String value,double? height,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height ?? 45,
        width: MediaQuery.of(context).size.width/4.9,
        child: ElevatedButton(
          onPressed: value == '⌫' ? onBackspaceTap
              : value == 'تثبيت' ? onReserveTap
              : () => onKeyTap(value),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}


