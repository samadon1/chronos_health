import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';

class PPHScreen extends StatefulWidget {
  const PPHScreen({Key? key}) : super(key: key);

  @override
  State<PPHScreen> createState() => _PPHScreenState();
}

class _PPHScreenState extends State<PPHScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Postpartum Hemorrhage"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Postpartum hemorrhage (PPH) is heavy bleeding (500 ml or more) after child birth that causes the patient to deteriote",
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 30),
                Text("First answer these questions:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                Text(
                    "1. How long has the patient been bleeding after delivery?\n2. What is the amount of bleeding, any fainting or shock?\n3.What is the date and time of delivery?\n4. How was the baby delivered? Was it caesarean birth?\n5. Were there any interventions?"),
                SizedBox(height: 30),
                Text("Telemedicine protocol for PPH:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                Text("Examination",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    "• General physical examination e.g. for pallor\n• Check perineum and vaginal area for signs of tears\n• Palpate/feel the uterus to see if it is shrunk/contracted\n• Examine the placenta and membrane for completeness"),
                SizedBox(height: 20),
                Text(
                    "Note: History, examination and resuscitation should be done at the same time. Every minute is important.",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                Image.asset("assets/images/bimanual.gif"),
                Align(
                    alignment: Alignment.center,
                    child: Text("Bimanual compression")),
                SizedBox(height: 20),
                Text("Management/Therapeutic strategies:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                Text("Basic level",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                    "• Give or continue IV fluids - 500 ml normal saline or Ringer's \t\t\tlactate. Give as much as needed to maintain circulation.\n• Monitor for signs of shock(pale, blood pressure(BP) < 90/60 mmHg, very fast pulse > 120 beats per minute)\n• Give oxygen\n• Take blood for Bh, grouping and cross-matching if not already done."),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
