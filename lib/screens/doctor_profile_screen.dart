import 'package:chronos_health/screens/appointment_screen.dart';
import 'package:chronos_health/screens/doctor_screen/chat_screen.dart';
import 'package:chronos_health/screens/doctor_screen/doctor_chat.dart';
import 'package:chronos_health/screens/video/rtc.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import '../video_screen/video_call.dart';

String url = 'tel:+91224578781';

class DoctorProfileScreen extends StatefulWidget {
  final String name;
  final String image;
  final String email;
  final String about;
  final String bio;
  const DoctorProfileScreen(
      {Key? key,
      required this.email,
      required this.name,
      required this.image,
      required this.about,
      required this.bio})
      : super(key: key);

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  Future<void> callnow() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'call not possible';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title: const Text(
          "Doctor profile",
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Column(
                      children: [
                        Hero(
                          tag: "docChat",
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: widget.image.isNotEmpty
                                ? NetworkImage(widget.image)
                                : AssetImage("assets/images/profile.png")
                                    as ImageProvider,
                          ),
                        ),
                        Text(
                          widget.name,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                        Text(widget.email)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Material(
                    elevation: 15,
                    shadowColor: Colors.pinkAccent,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: Container(
                      width: 240,
                      padding: const EdgeInsets.all(12),
                      decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(44)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: const ShapeDecoration(
                                    color: secondaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(64)))),
                                // padding: EdgeInsets.all(4),
                                child: IconButton(
                                    padding: const EdgeInsets.all(4),
                                    color: Colors.white,
                                    onPressed: () {
                                      callnow();
                                    },
                                    icon: const Icon(
                                      Icons.call_outlined,
                                      size: 34,
                                    )),
                              ),
                              const Text(
                                "Voice call",
                                style: TextStyle(
                                    fontSize: 12, color: secondaryColor),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const ShapeDecoration(
                                    color: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(64)))),
                                // padding: EdgeInsets.all(4),
                                child: Column(
                                  children: [
                                    IconButton(
                                        padding: const EdgeInsets.all(4),
                                        color: Colors.white,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Chat_Screen(
                                                        docName: widget.name,
                                                        docImage: widget.image,
                                                        // email:
                                                        //     widget.email
                                                      )));
                                        },
                                        icon: const Icon(
                                          Icons.chat,
                                          size: 34,
                                        )),
                                  ],
                                ),
                              ),
                              const Text("Chat",
                                  style: TextStyle(
                                      fontSize: 12, color: secondaryColor))
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const ShapeDecoration(
                                    color: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(64)))),
                                // padding: EdgeInsets.all(4),
                                child: IconButton(
                                    padding: const EdgeInsets.all(4),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoCall()));
                                    },
                                    icon: const Icon(
                                      Icons.videocam_outlined,
                                      size: 34,
                                    )),
                              ),
                              const Text("Video call",
                                  style: TextStyle(
                                      fontSize: 12, color: secondaryColor))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                    elevation: 5,
                    shadowColor: Colors.black45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      title: Text(
                        "About",
                        style: TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          "Teleconsultation centers coach community health workers and advise on the treatment of their patients, helping them manage emergency cases that are beyond their capacity and avoiding unnecessary referrals. "),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Card(
                    elevation: 5,
                    shadowColor: Colors.black45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      title: Text(
                        "Hospital Location",
                        style: TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Amansie West District of the Ashanti Region",
                      ),
                    )),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AppointmentScreen(
                              name: widget.name,
                              image: widget.image,
                            )));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: const Text(
                      "Schedule appointment",
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
                const SizedBox(
                  height: 20,
                )
              ]),
        ),
      ),
    );
  }
}
