import 'package:chronos_health/screens/doctor_screen/chat_screen.dart';
import 'package:chronos_health/screens/doctor_screen/forum_screen.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorChat extends StatefulWidget {
  const DoctorChat({Key? key}) : super(key: key);

  @override
  _DoctorChatState createState() => _DoctorChatState();
}

class _DoctorChatState extends State<DoctorChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "General chats",
                style: TextStyle(color: secondaryColor),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Forum_Screen()));
              },
              child: SizedBox(
                height: 100,
                child: Card(
                  child: Center(
                    child: ListTile(
                      leading: Image.asset("assets/images/forum.png"),
                      title: const Text("Forum"),
                      subtitle: const Text(
                          "Get advise from different specialty doctors "),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
              child: Text(
                "Recent chats",
                style: TextStyle(color: secondaryColor),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chats")
                    .orderBy('created')
                    // .orderBy("date", descending: false)
                    .snapshots()
                    .distinct(),
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
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Chat_Screen(
                                                      docName: (snapshot.data!
                                                              as dynamic)
                                                          .docs[index]['name'],
                                                      docImage: (snapshot.data!
                                                              as dynamic)
                                                          .docs[index]['image'],
                                                      // email: (snapshot.data!
                                                      //         as dynamic)
                                                      //     .docs[index]['email'],
                                                    )));
                                      },
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white10,
                                        child: ListTile(
                                          leading: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                  // radius: 20,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/profile.png")

                                                  //  NetworkImage(
                                                  //     (snapshot.data! as dynamic)
                                                  //         .docs[index]['image']),
                                                  ),
                                            ],
                                          ),
                                          title: Text(
                                              (snapshot.data! as dynamic)
                                                  .docs[index]['name']),
                                          // subtitle: Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     const SizedBox(
                                          //       height: 5,
                                          //     ),
                                          //     Text((snapshot.data! as dynamic)
                                          //         .docs[index]['text']),
                                          //   ],
                                          // ),
                                        ),
                                      ),
                                    ),
                                    const Divider()
                                  ],
                                ),
                              )));
                })
          ],
        ),
      ),
    );
  }
}
