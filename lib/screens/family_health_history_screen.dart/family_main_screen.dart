import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';

class FamilyMain extends StatefulWidget {
  const FamilyMain({Key? key}) : super(key: key);

  @override
  _FamilyMainState createState() => _FamilyMainState();
}

class _FamilyMainState extends State<FamilyMain> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    ScrollController _controller = new ScrollController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          child: const Icon(Icons.add_outlined)),
      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Family"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined))
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(color: secondaryColor),
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder,
                  border: inputBorder,
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: primaryColor,
                  ),
                  filled: true,
                  hintText: "Search..."),
              onFieldSubmitted: (String _) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "You and Your Children",
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const FamilyCard(
                    name: "John Doe",
                    memberType: "You",
                    disease: "High blood pressure - 38\nDiabetes - 37",
                  ),
                  const FamilyCard(
                    name: "Peter Doe",
                    memberType: "Partner",
                    disease: "",
                  ),
                  const FamilyCard(
                    name: "Maria Doe",
                    memberType: "Daughter",
                    disease: "",
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Brothers & Sisters",
                      // style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const FamilyCard(
                    name: "John Doe",
                    memberType: "You",
                    disease: "High blood pressure - 38\nDiabetes - 37",
                  ),
                  const FamilyCard(
                    name: "Peter Doe",
                    memberType: "Partner",
                    disease: "",
                  ),
                  const FamilyCard(
                    name: "Maria Doe",
                    memberType: "Daughter",
                    disease: "",
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Grandparents",
                      // style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const FamilyCard(
                    name: "John Doe",
                    memberType: "You",
                    disease: "High blood pressure - 38\nDiabetes - 37",
                  ),
                  const FamilyCard(
                    name: "Peter Doe",
                    memberType: "Partner",
                    disease: "",
                  ),
                  const FamilyCard(
                    name: "Maria Doe",
                    memberType: "Daughter",
                    disease: "",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FamilyCard extends StatelessWidget {
  final String name;
  final String memberType;
  final String disease;
  const FamilyCard({
    Key? key,
    required this.disease,
    required this.memberType,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: EdgeInsets.symmetric(vertical: 2),
      // height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              leading: const CircleAvatar(),
              title: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(memberType), Text(disease)],
              ),
              trailing: const Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
