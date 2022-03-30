import 'package:chronos_health/screens/doctor_profile_screen.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:chronos_health/widgets/doctor_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  bool isShowUsers = false;
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_outlined)),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Find doctors near you",
              style: TextStyle(
                  fontSize: 44,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              controller: searchController,
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
                  labelText: "Search for a doctor"),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
              },
            ),
            const SizedBox(
              height: 22,
            ),
            const Text(
              "All results",
              style: TextStyle(color: primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            isShowUsers == true
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .where("name",
                            isGreaterThanOrEqualTo: searchController.text)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                            ),
                          ),
                        );
                      }
                      return Flexible(
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            scrollDirection: Axis.vertical,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DoctorProfileScreen(
                                            name: ((snapshot.data! as dynamic)
                                                .docs[index]['name']),
                                            image: ((snapshot.data! as dynamic)
                                                .docs[index]['photoUrl']),
                                            email: (snapshot.data! as dynamic)
                                                .docs[index]['name'],
                                            about: '',
                                            bio: '',
                                          )));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                      (snapshot.data! as dynamic).docs[index]
                                          ['photoUrl'],
                                    ),
                                  ),
                                  title: Text(((snapshot.data! as dynamic)
                                      .docs[index]['name'])),
                                  subtitle: Text(((snapshot.data! as dynamic)
                                      .docs[index]['name'])),
                                ),
                              );
                            }),
                      );
                    },
                  )
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
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
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorProfileScreen(
                                                  name: ((snapshot.data!
                                                          as dynamic)
                                                      .docs[index]['name']),
                                                  image: ((snapshot.data!
                                                          as dynamic)
                                                      .docs[index]['photoUrl']),
                                                  email: (snapshot.data!
                                                          as dynamic)
                                                      .docs[index]['email'],
                                                  about: '',
                                                  bio: '',
                                                )));
                                  },
                                  child: DocotorCard(
                                      snap: snapshot.data!.docs[index].data()),
                                )),
                      );
                    })
          ],
        ),
      )),
    );
  }
}
