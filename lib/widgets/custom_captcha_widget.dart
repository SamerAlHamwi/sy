


import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../screens/settings/settings.dart';


class CustomImageWidget extends StatelessWidget {
  CustomImageWidget({super.key,this.imageBytes,required this.isFirst});

  Uint8List? imageBytes;
  bool isFirst;

  @override
  Widget build(BuildContext context) {
    return imageBytes != null
        ? ClipRRect(
      // borderRadius: BorderRadius.circular(12),
      child: Image.memory(
        imageBytes!,
        height: 300,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    )
        : Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black12,
          // borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Text(
          isFirst ? SettingsData.getId1 : SettingsData.getId2,
        ),
      ),
    );
  }
}
