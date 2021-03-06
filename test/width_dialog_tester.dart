import 'package:sketchnotes2/dialogs/width_dialog.dart';
import 'package:flutter/material.dart';

class WidthDialogTester extends StatefulWidget {
  final double initialWidth;

  WidthDialogTester({@required this.initialWidth});

  @override
  State<WidthDialogTester> createState() {
    return WidthDialogTestingState(initialWidth);
  }
}

class WidthDialogTestingState extends State<WidthDialogTester> {
  final double initialWidth;
  double strokeWidth = 0;

  WidthDialogTestingState(this.initialWidth);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: MaterialButton(
            child: Text('Select Stroke Width'),
            onPressed: () async {
              final temp = await showDialog<double>(
                context: context,
                builder: (context) => WidthDialog(
                  strokeWidth: initialWidth,
                ),
              );
              setState(() {
                strokeWidth = temp;
              });
            },
          ),
        ),
        Text('Selected width $strokeWidth'),
      ],
    );
  }
}
