import 'package:flutter/material.dart';
import 'package:sketchnotes_flutter/models/pen.dart';
import 'package:sketchnotes_flutter/widgets/user_preferences_provider.dart';

class PaperPainter extends CustomPainter {
  PaperPainter(this.points, this.color);

  final List<Offset> points;
  final Color color;

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color
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
    final prefs = UserPreferencesProvider.of(context).currentPen;

    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        RenderBox referenceBox = context.findRenderObject();
        Offset localPosition =
            referenceBox.globalToLocal(details.globalPosition);
        setState(() {
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: StreamBuilder(
        stream: prefs,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return CustomPaint(
              painter: new PaperPainter(_points, (snapshot.data as Pen)?.color),
              size: Size.infinite);
        },
      ),
    );
  }

  void clear() {
    setState(() {
      _points = List();
    });
  }
}
