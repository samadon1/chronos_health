import 'package:chronos_health/screens/doctor_screen/chat_screen.dart';
import 'package:chronos_health/screens/doctor_screen/forum_screen.dart';
import 'package:chronos_health/screens/doctor_screen/patients_screen.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SharePage extends StatefulWidget {
  dynamic capturedImage;

  SharePage({Key? key, required this.capturedImage}) : super(key: key);

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  final _auth = FirebaseAuth.instance;
  // User? loggedInUser;

  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? loggedInUser = _auth.currentUser?.email;
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share to ..."),
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
            InkWell(
              onTap: () {
                setState(() {
                  _firestore.collection("forum").add({
                    "text": widget.capturedImage,
                    "user": loggedInUser,
                    'created': now,
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
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
                                onTap: () {
                                  setState(() {
                                    _firestore.collection("messages").add({
                                      "text": widget.capturedImage,
                                      "user": loggedInUser,
                                      'created': now,
                                      'id': _auth.currentUser!.uid +
                                          (snapshot.data! as dynamic)
                                              .docs[index]['name']
                                    });
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                                },
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _firestore
                                              .collection("messages")
                                              .add({
                                            "text": widget.capturedImage,
                                            "user": loggedInUser,
                                            'created': now,
                                            'id': _auth.currentUser!.uid +
                                                (snapshot.data! as dynamic)
                                                    .docs[index]['name']
                                          });
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        });
                                        // setState(() {
                                        //   _firestore
                                        //       .collection("messages")
                                        //       .add({
                                        //     "text": widget.capturedImage,
                                        //     "user": loggedInUser,
                                        //     'created': now,
                                        //   });
                                        //   Navigator.pop(context);
                                        //   Navigator.pop(context);
                                        // });
                                      },
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white10,
                                        child: ListTile(
                                          leading: Column(
                                            children: [
                                              CircleAvatar(
                                                // radius: 70,
                                                backgroundImage: NetworkImage(
                                                    (snapshot.data! as dynamic)
                                                        .docs[index]['image']),
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
