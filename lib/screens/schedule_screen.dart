import 'package:chronos_health/screens/dashboard_screen.dart';

import 'package:chronos_health/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Schedule",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("schedule")
                      .orderBy("date", descending: false)
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

                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    DashBoardScreen())));
                                      },
                                      child: Material(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18))),
                                        elevation: 20,
                                        shadowColor: Colors.black54,
                                        child: Container(
                                          height: 200,
                                          decoration: const ShapeDecoration(
                                              shape: RoundedRectangleBorder()),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 40,
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
                                                      Text(
                                                        ((snapshot.data!
                                                                    as dynamic)
                                                                .docs[index]
                                                            ['name']),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Text(
                                                        "Cardiologist",
                                                        style: TextStyle(
                                                            color:
                                                                primaryColor),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                decoration: ShapeDecoration(
                                                    color: Colors.blueGrey[50],
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)))),
                                                height: 60,
                                                width: 280,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      color: secondaryColor,
                                                    ),
                                                    Text((DateFormat(
                                                            'MMM d, yyy')
                                                        .format((snapshot.data!
                                                                as dynamic)
                                                            .docs[index]["date"]
                                                            .toDate()))),
                                                    const Icon(
                                                      Icons.alarm_on_outlined,
                                                      color: secondaryColor,
                                                    ),
                                                    Text(
                                                      ((snapshot.data!
                                                                  as dynamic)
                                                              .docs[index]
                                                          ['time'])[0],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
