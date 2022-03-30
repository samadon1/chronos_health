import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';

class FeverChild extends StatefulWidget {
  const FeverChild({Key? key}) : super(key: key);

  @override
  State<FeverChild> createState() => _FeverChildState();
}

class _FeverChildState extends State<FeverChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fever - Child"),
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
                // Text(
                //     "Postpartum hemorrhage (PPH) is heavy bleeding (500 ml or more) after child birth that causes the patient to deteriote",
                //     style: TextStyle(fontSize: 18)),
                // SizedBox(height: 30),
                Text("First answer these questions:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                Text(
                    "1. Age of the child\n2. What is the child's temperature now?(if greater than 38.5C, do tepid sponging)?\n3. Duration of fever\n4. Has the child convulsed?\n5. Has malaria rapid diagnostic test(RDT) been conducted?\n6. If yes(RDT has been conducted), is it positive or negative?"),
                SizedBox(height: 30),
                Text("Telemedicine protocol for PPH:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                Text(
                    "Management/Therapeutic strategies\nPre-referral treatments",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    "• Symptoms include:\n- Currently having convulsions or has had 2 or more seizures\n- Neck stiffness\n- Very weak/coma\n- Dysphagia/drooling or painful swallowing\n- Fast or difficult breathing"),
                SizedBox(height: 20),
                Text(
                    "Treatment:\nGive ampicillin/penicillin plus gentamycin(if availbale)",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Image.asset("assets/images/rdt.jpg"),
                // Align(
                //     alignment: Alignment.center,
                //     child: Text("Bimanual compression")),
                // SizedBox(height: 20),
                // Text("Management/Therapeutic strategies:",
                //     style:
                //         TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                // SizedBox(height: 10),
                // Text("Basic level",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //     )),
                // Text(
                //     "• Give or continue IV fluids - 500 ml normal saline or Ringer's \t\t\tlactate. Give as much as needed to maintain circulation.\n• Monitor for signs of shock(pale, blood pressure(BP) < 90/60 mmHg, very fast pulse > 120 beats per minute)\n• Give oxygen\n• Take blood for Bh, grouping and cross-matching if not already done."),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
