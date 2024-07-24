

import 'dart:typed_data';

import 'package:flutter/material.dart';

class EquationWidget extends StatelessWidget {

  EquationWidget({super.key,required this.imageBytes});

  Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.memory(
        imageBytes,
        height: 250,
        width: 300,
      ),
    );
  }
}
