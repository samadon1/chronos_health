import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';

class ViewPatientData extends StatelessWidget {
  String uri;
  ViewPatientData({Key? key, required this.uri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Patient data"),
      ),
      body: SafeArea(
        child: Container(
          child: Image.network(uri),
        ),
      ),
    );
  }
}
