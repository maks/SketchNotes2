import 'package:flutter/material.dart';
import 'package:sketchnotes_flutter/widgets/paper_widget.dart';
import 'package:sketchnotes_flutter/widgets/shared_preferences_builder.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

const List _colors = [
  NamedColor("Blue", Colors.blue),
  NamedColor("Yellow", Colors.yellow),
  NamedColor("Black", Colors.black)
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sketch Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sketch Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _paper = PaperWidget();
  Color _currentColor = _colors[0].color;

  @override
  Widget build(BuildContext context) {
    return SharedPreferencesBuilder(
      pref: "pen.color",
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              IconButton(
                icon: Icon(choices[0].icon),
                onPressed: () {
                  _select(context, choices[0]);
                },
              ),
              DropdownButton<Color>(
                value: _currentColor,
                items: buildColorList(),
                onChanged: (selected) {
                  print("onchange $selected");
                  _setColor(selected);
                },
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: _backgroundBuilder(color: Colors.blue),
              ),
            ],
          ),
        );
      },
    );
  }

  void _select(BuildContext context, Choice choice) {
    setState(() {
      // clear paper
      print("CLEAR");
      _paper.clear();
    });
  }

  void _addPage() {
    //TODO
  }

  void _setColor(Color c) {
    _currentColor = c;
    _paper.penColor(c);
  }

  List<DropdownMenuItem<Color>> buildColorList() {
    return _colors
        .map(
            (c) => DropdownMenuItem<Color>(value: c.color, child: Text(c.name)))
        .toList();
  }

  Widget _backgroundBuilder({Color color = Colors.black}) {
    return GridPaper(
      color: color,
      divisions: 1,
      subdivisions: 1,
      interval: 25,
      child: _paper,
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'New', icon: Icons.clear),
];
