import 'package:chronos_health/utils/colors.dart';
import 'package:chronos_health/widgets/ml_widgets/card_scan_screen.dart';
import 'package:chronos_health/widgets/text_field_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PatientForm extends StatefulWidget {
  const PatientForm({Key? key}) : super(key: key);

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _dateofbirth = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _healthinsuramce = TextEditingController();
  final TextEditingController _heartrate = TextEditingController();
  final TextEditingController _respiratoryrate = TextEditingController();
  final TextEditingController _bloodpressure = TextEditingController();
  final TextEditingController _temperature = TextEditingController();
  final TextEditingController _bloodoxygen = TextEditingController();
  final TextEditingController _medications = TextEditingController();
  final TextEditingController _condition = TextEditingController();
  final TextEditingController _summary = TextEditingController();
  final TextEditingController _question = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Card_Scan()));
              },
              icon: const Icon(Icons.camera_alt_outlined)),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.share))
        ],
        backgroundColor: primaryColor,
        title: const Text("Patient's Info"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Personal details",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Full name",
                  textEditingController: _name,
                  textInputType: TextInputType.name),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Age",
                  textEditingController: _dateofbirth,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Gender",
                  textEditingController: _gender,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "NHI number",
                  textEditingController: _healthinsuramce,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Objective findings",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Heart rate",
                  textEditingController: _heartrate,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Respiratory rate",
                  textEditingController: _respiratoryrate,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Blood pressure",
                  textEditingController: _bloodpressure,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Temperature",
                  textEditingController: _temperature,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Blood oxygen",
                  textEditingController: _bloodoxygen,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Medical history",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Is patient on any medications?",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: secondaryColor),
              ),
              // DropdownButton(
              //     items: const [DropdownMenuItem(child: Text("No"))],
              //     onChanged: (_onChanged)),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _medications,
                maxLines: 2,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  // border: inputBorder,

                  enabled: true,
                  filled: true,
                  hintText: 'If yes, what medications?',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Does patient have a history of any chronic condition?",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: secondaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              // DropdownButton(
              //     items: const [DropdownMenuItem(child: Text("No"))],
              //     onChanged: (_onChanged)),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _condition,
                maxLines: 2,
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  enabledBorder: InputBorder.none,
                  // border: inputBorder,

                  enabled: true,
                  filled: true,
                  hintText: 'If yes, what condition?',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Assessment & plan",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _summary,
                maxLines: 2,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  // border: inputBorder,
                  enabled: true,
                  filled: true,
                  hintText: 'Clinical, individual, and contextual summary',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _question,
                maxLines: 2,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  // border: inputBorder,
                  enabled: true,
                  filled: true,
                  hintText: 'Clinical question',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _firestore.collection("patients").add({
                    "name": _name.text,
                    "age": _dateofbirth.text,
                    'gender': _gender.text,
                    'insurance': _healthinsuramce.text,
                    'heartrate': _heartrate.text,
                    'respiratoryrate': _respiratoryrate.text,
                    'bloodpressure': _bloodpressure.text,
                    'temperature': _temperature.text,
                    'bloodoxygen': _bloodoxygen.text,
                    'medications': _medications.text,
                    'condition': _condition.text,
                    'summary': _summary.text,
                    'question': _question.text
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  padding: const EdgeInsets.all(18),
                  decoration: const ShapeDecoration(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
