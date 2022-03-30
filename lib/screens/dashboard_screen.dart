import 'dart:typed_data';

import 'package:chronos_health/screens/family_health_history_screen.dart/family_main_screen.dart';
import 'package:chronos_health/screens/medication_screen.dart';
import 'package:chronos_health/screens/search_screen.dart';
import 'package:chronos_health/screens/vitals/main_vitals.dart';
import 'package:chronos_health/utils/vitals_containers.dart';
import 'package:chronos_health/video_screen/video_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Uint8List? file;

  String username = "";
  String scheduleTime = '';
  String schedulename = '';
  String scheduleImage = '';
  String scheduleDate = '';

  @override
  void initState() {
    super.initState();
    getUsername();
    getSchedule();
  }

  void getSchedule() async {
    try {
      if (username.isNotEmpty) {
        DocumentSnapshot snapSchedule = await FirebaseFirestore.instance
            .collection("schedule")
            .doc(_auth.currentUser!.uid)
            .get();
        if (mounted) {
          setState(() {
            schedulename =
                (snapSchedule.data() as Map<String, dynamic>)["name"];
            scheduleDate =
                (snapSchedule.data() as Map<String, dynamic>)["date"];
            scheduleImage =
                (snapSchedule.data() as Map<String, dynamic>)["Dimage"];
            scheduleTime =
                (snapSchedule.data() as Map<String, dynamic>)["time"];
          });
          print(snapSchedule);
        }
      }
    } catch (e) {}
  }

  void getUsername() async {
    try {
      if (username.isNotEmpty) {
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .get();
        if (mounted) {
          setState(() {
            username = (snap.data() as Map<String, dynamic>)["name"];
            file = (snap.data() as Map<String, dynamic>)["photoUrl"];
          });
        }
      }
    } catch (e) {}
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person_outlined),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text("Chronos Health"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 10,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      // height: 230,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Samuel Donkor",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 30),
                              child:
                                  Text("Chronos Bot: Prevention & Wellness")),
                          Container(
                            height: 80,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainVitals()));
                                        },
                                        child: Container(
                                          // height: 60,
                                          width: 260,
                                          padding:
                                              const EdgeInsets.only(left: 60),
                                          // width: 200,
                                          child: Card(
                                            elevation: 0,
                                            color: const Color.fromARGB(
                                                255, 242, 243, 245),
                                            child: ListTile(
                                              leading: Image.asset(
                                                "assets/images/pulse.png",
                                                scale: 15,
                                              ),
                                              title: Text("Clinical Vitals"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // height: 60,
                                        width: 260,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        // width: 200,
                                        child: Card(
                                          elevation: 0,
                                          color: Color.fromARGB(
                                              255, 242, 243, 245),
                                          child: ListTile(
                                            leading: Image.asset(
                                              "assets/images/exercise.png",
                                              scale: 15,
                                            ),
                                            title: Text("Exercise"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      )),
                  Divider(
                    thickness: 1,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("schedule")
                          .orderBy("date", descending: true)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                              height: 140,
                              child: Center(child: Text('Loading...')));
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return SizedBox(
                              height: 140,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                      'You have no upcoming appointments.'),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: primaryColor),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const SearchScreen())));
                                      },
                                      child: Text("Schdule an appointment"))
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
                          height: 140,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  // padding: EdgeInsets.symmetric(vertical: 0),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: ((context) => VideoScreen(
                                                    // dropRreason:
                                                    //     ((snapshot.data!
                                                    //                 as dynamic)
                                                    //             .docs[index]
                                                    //         ['dropReason']),
                                                    // reason: ((snapshot.data!
                                                    //         as dynamic)
                                                    //     .docs[index]['reason']),
                                                    // date: ((snapshot.data!
                                                    //         as dynamic)
                                                    //     .docs[index]['date']),
                                                    // image: ((snapshot.data!
                                                    //         as dynamic)
                                                    //     .docs[index]['Dimage']),
                                                    // time: ((snapshot.data!
                                                    //         as dynamic)
                                                    //     .docs[index]['time']),

                                                  ))));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Row(
                                        children: [
                                          Container(
                                            // height: 160,
                                            // padding: const EdgeInsets.symmetric(
                                            //     horizontal: 10, vertical: 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor:
                                                          primaryColor,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        ((snapshot.data!
                                                                    as dynamic)
                                                                .docs[index]
                                                            ['Dimage']),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              ((snapshot.data!
                                                                          as dynamic)
                                                                      .docs[index]
                                                                  [
                                                                  'dropReason']),
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          "Chronos Bot: Appointment",
                                                          style: TextStyle(
                                                              color:
                                                                  secondaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 60.0),
                                                  child: Container(
                                                    decoration: const ShapeDecoration(
                                                        color: Color.fromARGB(
                                                            255, 242, 243, 245),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12)))),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    // height: 50,
                                                    width: 230,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Icon(
                                                          Icons.calendar_today,
                                                          color:
                                                              Colors.blueAccent,
                                                        ),
                                                        Text(
                                                          (DateFormat(
                                                                  'MMM d, yyy')
                                                              .format((snapshot
                                                                          .data!
                                                                      as dynamic)
                                                                  .docs[index]
                                                                      ["date"]
                                                                  .toDate())),
                                                        ),
                                                        const Icon(
                                                          Icons.alarm_on,
                                                          color:
                                                              Colors.blueAccent,
                                                        ),
                                                        Text(
                                                          ((snapshot.data!
                                                                      as dynamic)
                                                                  .docs[index]
                                                              ['time'][0]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/drug.png",
                              width: 50,
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("meds")
                                    // .orderBy("date", descending: false)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container(
                                        height: 140,
                                        child:
                                            Center(child: Text('Loading...')));
                                  }
                                  if (snapshot.data!.docs.isEmpty) {
                                    return SizedBox(
                                        height: 140,
                                        child: Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // const Text(
                                            //     'You have no upcoming appointments.'),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blue),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              const MedicationScreen())));
                                                },
                                                child: Text("Add a medication"))
                                          ],
                                        )));
                                  }

                                  return SizedBox(
                                    height: 140,
                                    width: 280,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) =>
                                                InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            const MedicationScreen())));
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    right: 110, left: 10),
                                                // height: 120,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          ((snapshot.data!
                                                                      as dynamic)
                                                                  .docs[index]
                                                              ['name']),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Chronos Bot: Medication",
                                                      style: TextStyle(
                                                          color:
                                                              secondaryColor),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      decoration: ShapeDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              242,
                                                              243,
                                                              245),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12)))),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 20),
                                                      // height: 50,
                                                      width: 140,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .alarm_on_outlined,
                                                            color: Colors.green,
                                                          ),
                                                          Text("8:00 AM"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => FamilyMain())));
                    },
                    child: Container(
                      // height: 230,
                      width: MediaQuery.of(context).size.width - 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/note.png",
                                scale: 10,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Family Health History",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Understand your inherited risk for certain\nconditions, so that you can better\nmanage your health.",
                                    style: TextStyle(color: secondaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const Divider(
                            thickness: 1,
                          ),
                          // Flexible(
                          //   child: Container(),
                          //   flex: 2,
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) =>
                                        const SearchScreen())));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                child: const Text(
                                  "Need a doctor ?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                decoration: const ShapeDecoration(
                                    color: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24)))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //

                  // const SizedBox(height: 10),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class VitalsContainer extends StatelessWidget {
  const VitalsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Row(
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Icon(
                        //   Icons.pin_drop_outlined,
                        //   color: Colors.white,
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Blood pressure trends",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        Container(
                          child: const Text(
                            "141 / 90 mmhg",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    height: 180,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          colors: [
                            Colors.pink,
                            Colors.pinkAccent,
                            Colors.red,
                            Colors.redAccent
                            //add more colors for gradient
                          ],
                          begin:
                              Alignment.topLeft, //begin of the gradient color
                          end:
                              Alignment.bottomRight, //end of the gradient color
                          stops: [0, 0.1, 0.5, 0.8] //stops for individual color
                          //set the stops number equal to numbers of color
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Icon(
                        //   Icons.pin_drop_outlined,
                        //   color: Colors.white,
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Oxygen saturation",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        Container(
                          child: const Text(
                            "141 / 90 mmhg",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    height: 170,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.green,
                            Colors.greenAccent,
                            Colors.greenAccent
                            //add more colors for gradient
                          ],
                          begin:
                              Alignment.topLeft, //begin of the gradient color
                          end:
                              Alignment.bottomRight, //end of the gradient color
                          stops: [0, 0.1, 0.5, 0.8] //stops for individual color
                          //set the stops number equal to numbers of color
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Icon(
                        //   Icons.pin_drop_outlined,
                        //   color: Colors.white,
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Heart rate",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        Container(
                          child: const Text(
                            "141 / 90 mmhg",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    height: 170,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.blue,
                            Colors.blueAccent,
                            Colors.blueAccent
                            //add more colors for gradient
                          ],
                          begin:
                              Alignment.topLeft, //begin of the gradient color
                          end:
                              Alignment.bottomRight, //end of the gradient color
                          stops: [0, 0.1, 0.5, 0.8] //stops for individual color
                          //set the stops number equal to numbers of color
                          ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
