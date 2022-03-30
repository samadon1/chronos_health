import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';

class DocotorCard extends StatelessWidget {
  final snap;
  const DocotorCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Card(
        elevation: 0,
        shadowColor: Colors.black54,
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          title: Text(snap["name"]
              // (snapshot.data! as dynamic)
              //   .docs[index]["name"]
              ),
          subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  snap["email"],
                  style: const TextStyle(color: secondaryColor),
                ),
                Icon(
                  Icons.call_outlined,
                  color: primaryColor,
                ),
                // TextButton(
                //     onPressed: () {},
                //     child: Container(
                //       decoration: ShapeDecoration(
                //           color: Colors.blue,
                //           shape: RoundedRectangleBorder(
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(4)))),
                //       padding: EdgeInsets.all(4),
                //       child: Icon(
                //         Icons.call_outlined,
                //         color: Colors.white,
                //       ),
                //       // const Text(
                //       //   'Call',
                //       //   style: TextStyle(
                //       //     color: Colors.white,
                //       //   ),
                //       // ),
                //     ))
              ]),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(snap['photoUrl']),
          ),
        ),
      ),
    );
  }
}
