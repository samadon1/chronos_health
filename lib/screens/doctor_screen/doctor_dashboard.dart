import 'package:chronos_health/main.dart';
import 'package:chronos_health/screens/doctor_screen/chat_screen.dart';
import 'package:chronos_health/screens/doctor_screen/doctor_chat.dart';
import 'package:chronos_health/screens/doctor_screen/doctor_search.dart';
import 'package:chronos_health/screens/doctor_screen/learn.dart';
import 'package:chronos_health/screens/doctor_screen/patients_screen.dart';
import 'package:chronos_health/screens/login_screen.dart';
import 'package:chronos_health/screens/search_screen.dart';
import 'package:chronos_health/screens/vitals/main_vitals.dart';
import 'package:chronos_health/screens/vitals/ultrasound.dart';
import 'package:chronos_health/screens/vitals/vitals_screen.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:chronos_health/video_screen/video_call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({Key? key}) : super(key: key);

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _dashTextEditingScontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _auth.signOut();
                });
              },
              icon: Icon(Icons.person_outline)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
        // centerTitle: true,
        title: const Text("Chronos Health"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
          child: Expanded(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                        fontSize: 38,
                        color: secondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _dashTextEditingScontroller,
                    decoration: InputDecoration(
                        labelStyle: const TextStyle(color: secondaryColor),
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder,
                        border: inputBorder,
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          color: primaryColor,
                        ),
                        filled: true,
                        hintText: "Search for a medical protocol..."),
                    onFieldSubmitted: (String _) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Upcoming ",
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LearnPage()));
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black45,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              "assets/images/cbot.png",
                            ),
                          ),
                          title: const Text(
                            "Bot: Community Health Seminar",
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          ),
                          subtitle: const Text(
                            "Thursday, April 21st",
                            style: TextStyle(
                              color: Colors.blue,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PatientScreen()));
                          },
                          child: const DashCards(
                            title: "Patients",
                            image: AssetImage("assets/images/patient.png"),
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
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DoctorSearchScreen()),
                          );
                        },
                        child: const DashCards(
                          title: "Teleconsult ",
                          image: AssetImage("assets/images/consultant.png"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoctorChat()),
                          );
                        },
                        child: const DashCards(
                          title: "Chats ",
                          image: AssetImage("assets/images/forum.png"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const LearnPage()),
                          // );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LearnPage()
                                  // const LearnPage()
                                  ),
                            );
                          },
                          child: const DashCards(
                            title: "Resources ",
                            image: AssetImage("assets/images/book.png"),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]),
      )),
    );
  }
}

class DashCards extends StatelessWidget {
  final String title;
  final AssetImage image;
  const DashCards({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.black45,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SizedBox(
        height: 140,
        width: 150,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Image(
              image: AssetImage(image.assetName),
              width: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
