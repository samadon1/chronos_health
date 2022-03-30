import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';

import 'text_recognition.dart';

import '../../widgets/ml_widgets/text_recognition.dart';

class Card_Scan extends StatefulWidget {
  @override
  _Card_ScanState createState() => _Card_ScanState();
}

class _Card_ScanState extends State<Card_Scan> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("Scan card"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: const [
              SizedBox(height: 25),
              TextRecognitionWidget(),
              SizedBox(height: 15),
            ],
          ),
        ),
      );
}
