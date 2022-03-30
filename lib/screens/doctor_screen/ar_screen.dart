import 'package:flutter/material.dart';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARScreen extends StatefulWidget {
  ARScreen({
    Key? key,
  }) : super(key: key);
  @override
  _ARScreenState createState() => _ARScreenState();
}

ArCoreController arCoreController = ArCoreController(id: 1);

void whenArCoreViewCreated(ArCoreController controller) {
  final arCoreController = controller;
  arCoreController.onPlaneTap = controlOnPlaneTap;
}

void controlOnPlaneTap(List<ArCoreHitTestResult> results) {
  final hit = results.first;
  addItemImagetoScene(hit);
}

Future addItemImagetoScene(ArCoreHitTestResult hitTestResult) async {
  final bytes =
      (await rootBundle.load("assets/images/arHeart.png")).buffer.asUint8List();
  final imageItem = ArCoreNode(
    image: ArCoreImage(bytes: bytes, width: 600, height: 600),
    position: hitTestResult.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
    rotation: hitTestResult.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
  );
  arCoreController.addArCoreNodeWithAnchor(imageItem);
}

class _ARScreenState extends State<ARScreen> {
  @override
  Widget build(BuildContext context) {
    return const ArCoreView(
      onArCoreViewCreated: whenArCoreViewCreated,
      enableTapRecognizer: true,
    );
  }
}
