import 'package:flutter/material.dart';

class PaperPainter extends CustomPainter {
  PaperPainter(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  bool shouldRepaint(PaperPainter other) => other.points != points;
}

class PaperWidget extends StatefulWidget {
  final _state = PaperWidgetState();

  PaperWidgetState createState() => _state;

  void clear() {
    _state.clear();
  }
}

class PaperWidgetState extends State<PaperWidget> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        RenderBox referenceBox = context.findRenderObject();
        Offset localPosition =
            referenceBox.globalToLocal(details.globalPosition);
        //print("point $localPosition");
        setState(() {
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child:
          CustomPaint(painter: new PaperPainter(_points), size: Size.infinite),
    );
  }

  void clear() {
    setState(() {
      _points = List();
    });
  }
}
