import 'package:chronos_health/screens/doctor_screen/ar_screen.dart';
import 'package:chronos_health/screens/doctor_screen/doctor_dashboard.dart';
import 'package:chronos_health/screens/doctor_screen/learn/fever_child.dart';
import 'package:chronos_health/screens/doctor_screen/learn/pph.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({Key? key}) : super(key: key);

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
      body: SafeArea(
          child: Expanded(
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ARScreen()
                              // ARScreen(
                              //       itemImg: "assets/images/arHeart.png",
                              //     )
                              ));
                    },
                    child: Stack(children: [
                      Image.asset(
                        "assets/images/heart.jpg",
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                          )),
                      const Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 120),
                        child: Text(
                          "Explore the heart in AR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ))
                    ]),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "Telemedicine protocols",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // color: primaryColor
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PPHScreen()
                              // const LearnPage()
                              ),
                        );
                      },
                      child: SizedBox(
                        height: 100,
                        child: Card(
                          elevation: 0,
                          shadowColor: Colors.black87,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            leading: Image.asset(
                              "assets/images/preg.jpg",
                            ),
                            title: Text(
                                "Protocol for Postpartum hemorrhage - PPH"),
                            subtitle: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PPHScreen()
                                      // const LearnPage()
                                      ),
                                );
                              },
                              child: Text(
                                "View protocol",
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FeverChild()
                              // const LearnPage()
                              ),
                        );
                      },
                      child: SizedBox(
                        height: 100,
                        child: Card(
                          elevation: 0,
                          shadowColor: Colors.black87,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            leading: Image.asset(
                              "assets/images/child.png",
                            ),
                            title: const Text("Protocol for fever - Child"),
                            subtitle: const Text(
                              "View protocol",
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Card(
                        elevation: 0,
                        shadowColor: Colors.black87,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          leading: Image.asset(
                            "assets/images/adult.png",
                          ),
                          title: const Text("Protocol for fever - Adult"),
                          subtitle: const Text(
                            "View protocol",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Card(
                        elevation: 0,
                        shadowColor: Colors.black87,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          leading: Image.asset(
                            "assets/images/child1.jpg",
                          ),
                          title: const Text(
                              "Protocol for integrated management of childhood illness (IMCI) "),
                          subtitle: const Text(
                            "View protocol",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Events",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // color: primaryColor
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 320,
                      // width: 200,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        Row(
                          children: [
                            Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/vaccine.jpg",
                                    scale: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 18.0),
                                    child: Text(
                                        "Ensuring Fairness in COVID-19 Vaccine Rollout",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text("18th April, 2022 | Virtual",
                                        style: TextStyle(
                                            fontSize: 16, color: primaryColor)),
                                  )
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/nursecare.jpg",
                                      scale: 4),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Infection Prevention and Control \nin Maternal and Neonatal Care",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text("18th April, 2022 | Virtual",
                                        style: TextStyle(
                                            fontSize: 16, color: primaryColor)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    )

                    // SizedBox(
                    //   height: 100,
                    //   child: Card(
                    //     elevation: 5,
                    //     shadowColor: Colors.black87,
                    //     child: ListTile(
                    //       contentPadding: const EdgeInsets.symmetric(
                    //           vertical: 5, horizontal: 10),
                    //       leading: Image.asset(
                    //         "assets/images/vaccine.jpg",
                    //       ),
                    //       title: const Text(
                    //           "Ensuring Fairness in COVID-19 Vaccine Rollout"),
                    //       subtitle: const Text(
                    //         "Register Now",
                    //         style: TextStyle(color: primaryColor),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // SizedBox(
                    //   height: 100,
                    //   child: Card(
                    //     elevation: 5,
                    //     shadowColor: Colors.black87,
                    //     child: ListTile(
                    //       contentPadding: const EdgeInsets.symmetric(
                    //           vertical: 5, horizontal: 25),
                    //       leading: Image.asset(
                    //         "assets/images/nursecare.jpg",
                    //       ),
                    //       title:
                    //           const Text("Take Care With Hands, Eyes And Ears"),
                    //       subtitle: const Text(
                    //         "Happening Next Week",
                    //         style: TextStyle(color: primaryColor),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // const Text(
                    //   "Resources",
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //     // color: primaryColor
                    //   ),
                    // ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // SizedBox(
              //   height: 100,
              //   child: Card(
              //     elevation: 15,
              //     shadowColor: Colors.black87,
              //     child: ListTile(
              //       leading: Image.asset(
              //         "assets/images/doc.jpg",
              //       ),
              //       title: const Text("How Does Telemedicine Work?"),
              //       subtitle: const Text("WebMD.com"),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 100,
              //   child: Card(
              //     elevation: 15,
              //     shadowColor: Colors.black87,
              //     child: ListTile(
              //       contentPadding:
              //           const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              //       leading: Image.asset(
              //         "assets/images/bp.jpg",
              //       ),
              //       title:
              //           const Text("Understanding Blood \nPressure Readings"),
              //       subtitle: const Text("heart.org"),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 100,
              //   child: Card(
              //     elevation: 15,
              //     shadowColor: Colors.black87,
              //     child: ListTile(
              //       contentPadding:
              //           const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              //       leading: Image.asset(
              //         "assets/images/heartimage.jpg",
              //       ),
              //       title: const Text("Heart Disease Diagnosis"),
              //       subtitle: const Text("WebMD.com"),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 100,
              //   child: Card(
              //     elevation: 15,
              //     shadowColor: Colors.black87,
              //     child: ListTile(
              //       contentPadding:
              //           const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              //       leading: Image.asset(
              //         "assets/images/heartinfo.jpg",
              //       ),
              //       title: const Text("A Visual Guide to Heart Disease"),
              //       subtitle: const Text("WebMD.com"),
              //     ),
              //   ),
              // )
            ],
          ),
        ]),
      )),
    );
  }
}
