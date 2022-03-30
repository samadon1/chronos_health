import 'package:chronos_health/screens/dashboard_screen.dart';
import 'package:chronos_health/screens/home_screen.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:chronos_health/widgets/text_field_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final TextEditingController addDrugController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
      });
    }
  }

  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMM d, yyy').format(DateTime.now());

  List<Widget> medications = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addMed() async {
    String res = "An error occured";
    try {
      if (addDrugController.text.isNotEmpty ||
          selectedTime.format(context).isNotEmpty) {
        await _firestore.collection("meds").add({
          "name": addDrugController.text,
          "time": selectedTime,
          "uid": _auth.currentUser!.uid
        });

        res = "success";

        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const DashBoardScreen()));
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  @override
  void initState() {
    addMed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Medication"),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter mystate) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    height: 650,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: const Text(
                            "Medication details",
                            style: TextStyle(
                                fontSize: 24,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFieldInput(
                            hintText: "",
                            labelText: "Name of drug",
                            textEditingController: addDrugController,
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(secondaryColor)),
                          onPressed: () {
                            _selectTime(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Choose Time"),
                              // Text(
                              //     "${selectedTime.hour}:${selectedTime.minute}"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            try {
                              if (addDrugController.text.isNotEmpty ||
                                  selectedTime.format(context).isNotEmpty) {
                                await _firestore.collection("meds").add({
                                  "name": addDrugController.text,
                                  "time": selectedTime.format(context),
                                  "uid": _auth.currentUser!.uid
                                });
                              }
                            } catch (e) {}
                            setState(() {
                              medications.add(MedicationCard(
                                  name: addDrugController.text,
                                  time: selectedTime.format(context)));

                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            color: primaryColor,
                            child: const Text(
                              "Add Reminder",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 12,
              ),
              // // ),
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                elevation: 30,
                shadowColor: Colors.black38,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 1,
                      )
                    ],
                  ),
                  trailing: const Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
                  subtitle: const Text(
                      "Your refills of Hydrochlorothiazide are running low. We're coordinating with Dr. Akowuah for more refills."),
                ),
              ),
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              //   child: const Text(
              //     "For today",
              //     style: TextStyle(
              //         color: secondaryColor,
              //         fontSize: 24,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(
              //   height: 400,
              //   child: ListView.builder(
              //     scrollDirection: Axis.vertical,
              //     itemCount: medications.length,
              //     itemBuilder: (context, index) {
              //       return medications[index];
              //     },
              //   ),
              // ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("meds")
                      // .orderBy("date", descending: false)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }

                    return SizedBox(
                        height: 470,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {},
                                child: MedicationCard(
                                  name: ((snapshot.data! as dynamic).docs[index]
                                      ['name']),
                                  time: ((snapshot.data! as dynamic).docs[index]
                                      ['time']),
                                ))));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final String name;
  final String time;
  const MedicationCard({Key? key, required this.name, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      shadowColor: Colors.black38,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        leading: Image.asset(
          "assets/images/drug.png",
          scale: 2,
        ),

        // const Icon(
        //   Icons.alarm_add_outlined,
        //   color: Colors.green,
        // ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 22),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: secondaryColor,
        ),
        subtitle: Text(time),
      ),
    );
  }
}
