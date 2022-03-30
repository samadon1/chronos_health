import 'package:chronos_health/screens/doctor_screen/view_patient_data.dart';
import 'package:chronos_health/screens/video/rtc.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:chronos_health/video_screen/video_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../video_screen/video_call.dart';

String url = 'tel:+91224578781';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
late User loggedInUser;
final loggedInUserMail = _auth.currentUser!.email;

class Chat_Screen extends StatefulWidget {
  String docName;
  String docImage;
  // String email;
  Chat_Screen(
      {Key? key,
      // required this.email,
      required this.docName,
      required this.docImage})
      : super(key: key);

  static const String id = "chat";

  @override
  _Chat_ScreenState createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  Future<void> callnow() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'call not possible';
    }
  }

  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  late String messageText;
  late Timestamp time;

  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
          print(loggedInUser.email);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {
        print(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    // String id1 = loggedInUserMail! + widget.email;
    // String id2 = widget.email + loggedInUserMail!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                callnow();
              },
              icon: const Icon(Icons.call_outlined)),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => VideoCall()));
              },
              icon: Icon(Icons.video_call_rounded))
        ],
        title: Row(
          children: [
            Hero(
              tag: "docChat",
              child: CircleAvatar(
                backgroundImage: widget.docImage.isNotEmpty
                    ? NetworkImage(widget.docImage)
                    : AssetImage("assets/images/profile.png") as ImageProvider,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(child: SingleChildScrollView(child: Text(widget.docName))),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection("messages")
                  // .where("id", isEqualTo: id)
                  // .where("id1", isEqualTo: id1)
                  // .where("id2", isEqualTo: id2)
                  // .where("id2", isEqualTo: id2)
                  // .orderBy("created")
                  // .orderBy('created', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 180),
                          child: const CircularProgressIndicator(
                            color: primaryColor,
                            // backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                final messages = snapshot.data!.docs.reversed;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages) {
                  final messageText = message.get('text');
                  final messageSender = message.get('user');
                  final time = message.get('created');

                  final currentUser = loggedInUser.email;

                  final messageBubble = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    isMe: currentUser == messageSender,
                    created: time,
                  );
                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: ListView(
                      reverse: true,
                      children: messageBubbles,
                    ),
                  ),
                );
              }),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 50,
                    width: 220,
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        messageText = value;
                        messagesStream();
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Message',
                        hintStyle: const TextStyle(fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: primaryColor, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 5),
                  child: SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        messageController.clear();
                        _firestore.collection("messages").add({
                          "text": messageText,
                          "user": loggedInUserMail,
                          'created': now,
                          // 'id1': id1,
                          // 'id2': id2,
                          'image': widget.docImage,
                          'name': widget.docName
                        });
                        _firestore.collection("chats").doc().set({
                          "text": messageText,
                          "user": loggedInUserMail,
                          'created': now,
                          // 'id1': id1,
                          // 'id2': id2,
                          'image': widget.docImage,
                          'name': widget.docName
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0),
                          )),
                      child: Text("Send"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatefulWidget {
  final String? sender;
  final String text;
  final Timestamp? created;
  final bool? isMe;
  const MessageBubble(
      {Key? key,
      required this.sender,
      required this.text,
      required this.created,
      required this.isMe})
      : super(key: key);

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  // var timeSent;
  // var dateSent;
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class MessageBubble extends StatelessWidget {
//   MessageBubble(
//       {required this.sender,
//       required this.text,
//       required this.isMe,
//       required this.created});

//   final String sender;
//   final String text;
//   final Timestamp created;
//   final bool isMe;

  // setTimeStamp() {
  //   timeSent = widget.created?.toDate();
  //   timeSent = DateFormat('kk:mm').format(timeSent);
  // }

  // setDateStamp() {
  //   dateSent = widget.created?.toDate();
  //   dateSent = DateFormat('dd-MM').format(dateSent);
  // }

  @override
  void initState() {
    // setTimeStamp();
    // setDateStamp();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: widget.text.contains("https")
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewPatientData(uri: widget.text)));
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: widget.isMe!
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  // crossAxisAlignment: widget.isMe!
                  //   ? CrossAxisAlignment.end
                  //   : CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/profile.png"),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Patient's data",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Tap to view",
                          style: TextStyle(color: primaryColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          : Column(
              crossAxisAlignment: widget.isMe!
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Center(child: widget.created == null ? Text('') : Text("$dateSent")),
                SelectableText(
                  widget.sender!,
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                ),
                Material(
                  borderRadius: widget.isMe!
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))
                      : const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                  elevation: 5.0,
                  color: widget.isMe! ? primaryColor : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: SelectableText(
                      widget.text,
                      style: TextStyle(
                          fontSize: 15,
                          color: widget.isMe! ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                // Text(
                //   "$timeSent",
                //   style: const TextStyle(color: Colors.black38, fontSize: 13.0),
                // )
              ],
            ),
    );
  }
}
