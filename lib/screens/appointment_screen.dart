import 'package:chronos_health/screens/dashboard_screen.dart';
import 'package:chronos_health/screens/home_screen.dart';
import 'package:chronos_health/screens/schedule_screen.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';

late DateTime selectedValue;

TextEditingController reasonController = TextEditingController();

class AppointmentScreen extends StatefulWidget {
  final String name;
  final String image;
  const AppointmentScreen({Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<String> time = [
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "2:00 PM",
    "4:00 PM",
    "6:00 PM"
  ];

  String dropReason = "Vaccination / Testing";
  String realTime = '';

  // List<String>.fiiled updateTime = [" "];

  List<String> updateTime = ["10:00 AM"];

  bool timeTap = false;
  Color timeTapColorful = Color.fromARGB(255, 198, 199, 201);

  void startRecord() async {}

  @override
  void initState() {
    name:
    widget.name;
    super.initState();
  }

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> scheduleDetails() async {
    String res = "An error occured";
    try {
      if (widget.name.isNotEmpty ||
          updateTime.isNotEmpty ||
          reasonController.text.isNotEmpty) {
        await _firestore.collection("schedule").add({
          "name": widget.name,
          "time": updateTime,
          "dropReason": dropReason,
          "reason": reasonController.text,
          // "uid": _auth.currentUser!.uid,
          "date": selectedValue,
          "Dimage": widget.image,
          "uid": _auth.currentUser!.uid
        });

        //     .doc(_auth.currentUser!.uid)
        //     .({
        //   "name": widget.name,
        //   "date": updateTime,
        //   "reason": reasonController.text,
        // });
        res = "success";

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashBoardScreen()));
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule an appointment"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(scrollDirection: Axis.vertical, children: [
          SizedBox(
            height: 680,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   "Select Time Slot",
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //       color: secondaryColor),
                // ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: primaryColor,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          selectedValue = date;
                          print(selectedValue);
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   "Visiting Hours",
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //       color: secondaryColor),
                // ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: updateTime.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                const Center(child: Text("Selected time :")),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    height: 40,
                                    width: 85,
                                    padding: const EdgeInsets.all(12),
                                    decoration: const ShapeDecoration(
                                        color: primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18)))),
                                    child: Text(
                                      updateTime[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: time.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  timeTap == true;
                                  updateTime.isNotEmpty
                                      ? updateTime.removeAt(0)
                                      : null;
                                  updateTime.add(time[index]);
                                  realTime = time[index];
                                });
                              },
                              child: Container(
                                  height: 40,
                                  width: 85,
                                  padding: const EdgeInsets.all(12),
                                  decoration: ShapeDecoration(
                                      color: timeTapColorful,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)))),
                                  child: Text(
                                    time[index],
                                    style: const TextStyle(color: Colors.white),
                                  )),
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  thickness: 1,
                ),

                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "How can we help you ?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: secondaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  hint: Text(dropReason),
                  items: <String>[
                    'New Issue',
                    'Follow up',
                    'Physical / Wellness Checkup',
                    'Vaccination / Testing'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_value) {
                    setState(() {
                      dropReason = _value!;
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                const Text(
                  "Is there anything else we need to know ?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: secondaryColor),
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: secondaryColor),
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    border: inputBorder,
                    filled: true,
                    hintMaxLines: 20,
                    // labelText: "Search for a doctor"
                  ),
                  onFieldSubmitted: (String _) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                // Center(
                //   child: Container(
                //     width: 65,
                //     alignment: Alignment.center,
                //     padding: const EdgeInsets.only(right: 100),
                //     height: 65,
                //     decoration: const ShapeDecoration(
                //         color: primaryColor,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(80)),
                //         )),
                //     child: Column(
                //       children: [
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.mic_rounded,
                //       size: 50,
                //       color: Colors.white,
                //     )),

                // Text(
                //   "Tap to record",
                //   style: TextStyle(color: Colors.white),
                // )
                //   ],
                // ),
                // ),

                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const AppointmentScreen()));
                  },
                  child: InkWell(
                    onTap: () {
                      scheduleDetails();
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      child: const Text(
                        "Confirm appointment",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      padding: const EdgeInsets.all(18),
                      decoration: const ShapeDecoration(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
