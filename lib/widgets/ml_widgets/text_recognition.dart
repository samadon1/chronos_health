import 'dart:io';

import 'package:chronos_health/utils/colors.dart';
import 'package:clipboard/clipboard.dart';
import 'text_area_widget.dart';
import 'firebase_ml.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'controlls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key? key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File? image;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Expanded(child: buildImage()),
            const SizedBox(height: 16),
            ControlsWidget(
              onClickedPickImage: pickImage,
              onClickedScanText: scanText,
              onClickedClear: clear,
            ),
            const SizedBox(height: 16),
            TextAreaWidget(
              text: text,
              onClickedCopy: copyToClipboard,
            ),
          ],
        ),
      );

  Widget buildImage() => Container(
        child: image != null
            ? Image.file(image!)
            : Image.asset(
                "assets/images/scan.png",
                color: secondaryColor,
                scale: 2,
              ),
      );

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file!.path));
  }

  Future scanText() async {
    showDialog(
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
      context: context,
    );

    // final text = await FirebaseMLApi.recogniseText(image!);
    setText(text);

    Navigator.of(context).pop();
  }

  void clear() {
    setImage(File(""));
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }
}
