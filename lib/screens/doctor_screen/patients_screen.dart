import 'package:chronos_health/screens/doctor_screen/patient_details.dart';
import 'package:chronos_health/screens/doctor_screen/patient_forms.dart';
import 'package:chronos_health/screens/doctor_screen/search_patient.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPatient()));
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings))
        ],
        title: const Text("Patients"),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_outline),
        label: const Text("Add patient"),
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PatientForm()));
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // height: 1000,
          child: Column(children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("patients")
                    // .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        height: 140,
                        child: const Center(child: const Text('Loading...')));
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return SizedBox(
                        height: 140,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('No patients added'),
                          ],
                        )));
                  }

                  // if (snapshot.connectionState ==
                  //     ConnectionState.waiting) {
                  //   return const Center(
                  //       // child: CircularProgressIndicator(
                  //       //   color: primaryColor,
                  //       // ),
                  //       );
                  // }

                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PatientDetails(
                                                age:
                                                    ((snapshot.data! as dynamic)
                                                        .docs[index]['age']),
                                                bloodoxygen:
                                                    ((snapshot.data! as dynamic)
                                                            .docs[index]
                                                        ['bloodoxygen']),
                                                bloodpressure:
                                                    ((snapshot.data! as dynamic)
                                                            .docs[index]
                                                        ['bloodpressure']),
                                                condition: ((snapshot.data!
                                                        as dynamic)
                                                    .docs[index]['condition']),
                                                gender:
                                                    ((snapshot.data! as dynamic)
                                                        .docs[index]['gender']),
                                                heartrate: ((snapshot.data!
                                                        as dynamic)
                                                    .docs[index]['heartrate']),
                                                insurance: ((snapshot.data!
                                                        as dynamic)
                                                    .docs[index]['insurance']),
                                                medications:
                                                    ((snapshot.data! as dynamic)
                                                            .docs[index]
                                                        ['medications']),
                                                name:
                                                    ((snapshot.data! as dynamic)
                                                        .docs[index]['name']),
                                                question: ((snapshot.data!
                                                        as dynamic)
                                                    .docs[index]['question']),
                                                respiratoryrate:
                                                    ((snapshot.data! as dynamic)
                                                            .docs[index]
                                                        ['respiratoryrate']),
                                                summary: ((snapshot.data!
                                                        as dynamic)
                                                    .docs[index]['summary']),
                                                temperature:
                                                    ((snapshot.data! as dynamic)
                                                            .docs[index]
                                                        ['temperature']),
                                              )));
                                },
                                child: ListTile(
                                  // trailing: IconButton(
                                  //     onPressed: () {},
                                  //     icon: Icon(Icons.share_rounded)),
                                  leading: const CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/profile.png"),
                                    backgroundColor: primaryColor,
                                  ),
                                  title: Text(
                                    ((snapshot.data! as dynamic).docs[index]
                                        ['name']),
                                  ),
                                  subtitle: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        ((snapshot.data! as dynamic).docs[index]
                                            ['insurance']),
                                        style: const TextStyle(
                                            color: secondaryColor),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      // const Text(
                                      //   "Share",
                                      //   style: TextStyle(color: Colors.blue),
                                      // )
                                    ],
                                  ),
                                ),
                              )));
                }),
          ]),
        ),
      ),
    );
  }
}
