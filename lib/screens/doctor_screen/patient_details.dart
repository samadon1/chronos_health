import 'dart:typed_data';

import 'package:chronos_health/screens/doctor_screen/share_page.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../resources/storage_methods.dart';

class PatientDetails extends StatefulWidget {
  String name;
  String age;
  String gender;
  String insurance;
  String heartrate;
  String respiratoryrate;
  String bloodpressure;
  String temperature;
  String bloodoxygen;
  String medications;
  String condition;
  String summary;
  String question;
  PatientDetails(
      {Key? key,
      required this.name,
      required this.age,
      required this.gender,
      required this.insurance,
      required this.bloodoxygen,
      required this.bloodpressure,
      required this.condition,
      required this.heartrate,
      required this.medications,
      required this.question,
      required this.respiratoryrate,
      required this.summary,
      required this.temperature})
      : super(key: key);

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Row(
            children: [
              const Text("Edit"),
              const SizedBox(
                width: 10,
              ),

              InkWell(
                  onTap: () {
                    screenshotController
                        .capture(delay: const Duration(milliseconds: 1))
                        .then((capturedImage) async {
                      ShowCapturedWidget(context, capturedImage!);
                      String photoUrl = await StorageMethods()
                          .uploadImageToStorage(
                              "profilePics", capturedImage, false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SharePage(
                                    capturedImage: photoUrl,
                                  )));
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  child: const Text("Share")),
              const SizedBox(
                width: 10,
              )
              // IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            ],
          )
        ],
        backgroundColor: primaryColor,
        title: const Text("Patient's details"),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.gender,
                        style: const TextStyle(color: primaryColor),
                      ),
                      Text(
                        "," + widget.age,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.insurance),
              const Divider(
                thickness: 1,
              ),
              const Text(
                "Objective findings",
                style: TextStyle(fontSize: 18, color: primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Heart rate"),
              Text(
                widget.heartrate,
                style: const TextStyle(fontSize: 18, color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Blood pressure"),
              Text(
                widget.bloodpressure,
                style: const TextStyle(fontSize: 18, color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Blood oxygen"),
              Text(
                widget.bloodoxygen,
                style: const TextStyle(fontSize: 18, color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Temperature"),
              Text(
                widget.temperature,
                style: const TextStyle(fontSize: 18, color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Respiratory rate"),
              Text(
                widget.respiratoryrate,
                style: const TextStyle(fontSize: 18, color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const Text(
                "Medical history",
                style: TextStyle(fontSize: 18, color: primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Medications"),
              Text(
                widget.medications,
                style: const TextStyle(fontSize: 18, color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Chronic condition"),
              Text(widget.condition,
                  style: const TextStyle(fontSize: 18, color: secondaryColor)),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Assessment & plan",
                style: TextStyle(fontSize: 18, color: primaryColor),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Clinical, individual, and contextual summary"),
              Text(
                widget.summary,
                style: const TextStyle(fontSize: 18, color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Clinical question"),
              Text(
                widget.question,
                style: const TextStyle(fontSize: 18, color: secondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text("Patient's details")),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }
}
