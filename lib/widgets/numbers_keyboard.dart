


import 'package:flutter/material.dart';



class CustomNumberKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyTap;
  final VoidCallback onBackspaceTap;
  final VoidCallback onReserveTap;

  const CustomNumberKeyboard({super.key,
    required this.onKeyTap,
    required this.onBackspaceTap,
    required this.onReserveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildNumberRow(['1', '2', '3']),
          _buildNumberRow(['4', '5', '6']),
          _buildNumberRow(['7', '8', '9']),
          _buildNumberRow(['تثبيت', '0', '⌫']),
        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> values) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values.map((value) {
        return _buildNumberKey(value);
      }).toList(),
    );
  }

  Widget _buildNumberKey(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed:
          value == '⌫' ? onBackspaceTap
          : value == 'تثبيت' ? onReserveTap
          : () => onKeyTap(value),
          child: Text(
            value,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}


