//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:image/image.dart' as img;
//
//
// class ImagePage extends StatefulWidget {
//
//   const ImagePage({super.key});
//
//   @override
//   _ImagePageState createState() => _ImagePageState();
// }
//
//
// class _ImagePageState extends State<ImagePage> {
//   String _text = 'Loading image...';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadImageAndPerformOCR();
//   }
//
//
//   Future<void> _loadImageAndPerformOCR() async {
//     // Load image from assets
//     final byteData = await rootBundle.load('assets/2.jpg');
//     final file = File('${(await getTemporaryDirectory()).path}/2.jpg');
//     await file.writeAsBytes(byteData.buffer.asUint8List());
//
//     String test = await recognizeText(file);
//
//     setState(() {
//       _text = test;
//     });
//
//     textRecognizer.close();
//   }
//
//
//   final textRecognizer = GoogleMlKit.vision.textRecognizer();
//
//   // Future<String> recognizeText(File imageFile) async {
//   //   final inputImage = InputImage.fromFile(imageFile);
//   //   final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//   //
//   //   String result = '';
//   //   for (TextBlock block in recognizedText.blocks) {
//   //     for (TextLine line in block.lines) {
//   //       result += '${line.text}\n';
//   //     }
//   //   }
//   //
//   //   return result;
//   // }
//
//   Future<String> recognizeText(File imageFile) async {
//     // Load the image
//     final originalImage = img.decodeImage(imageFile.readAsBytesSync())!;
//
//     // Preprocess the image: Enhance contrast and sharpen
//     // img.Image preprocessedImage = img.grayscale(originalImage);
//     // preprocessedImage = img.adjustColor(preprocessedImage, contrast: 1.5);
//     // preprocessedImage = img.smooth(preprocessedImage, amount: 1);
//
//     // Save the preprocessed image to a temporary file
//     // final tempDir = await getTemporaryDirectory();
//     // final preprocessedFile = File('${tempDir.path}/preprocessed_image.png');
//     // preprocessedFile.writeAsBytesSync(img.encodePng(preprocessedImage));
//
//     // Perform OCR on the preprocessed image
//     final inputImage = InputImage.fromFile(imageFile);
//     final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//
//     String result = '';
//     for (TextBlock block in recognizedText.blocks) {
//       for (TextLine line in block.lines) {
//         result += '${line.text}\n';
//       }
//     }
//
//     return result;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('OCR with Flutter'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(_text,style: const TextStyle(fontSize: 25),),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
