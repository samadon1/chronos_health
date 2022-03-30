import 'package:chronos_health/utils/colors.dart';
import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback? onClickedPickImage;
  final VoidCallback? onClickedScanText;
  final VoidCallback? onClickedClear;

  const ControlsWidget({
    @required this.onClickedPickImage,
    @required this.onClickedScanText,
    @required this.onClickedClear,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            color: primaryColor,
            onPressed: onClickedPickImage,
            child: const Text(
              'Pick Image',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          RaisedButton(
            color: primaryColor,
            onPressed: onClickedScanText,
            child: Text(
              'Scan Image',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          // RaisedButton(
          //   onPressed: onClickedClear,
          //   child: Text('Clear'),
          // )
        ],
      );
}
