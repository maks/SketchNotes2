import 'package:flutter/material.dart';
import 'package:sketchnotes_flutter/widgets/paper_widget.dart';

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

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _backgroundBuilder(
              color: Colors.blue
            ),
          ),
        ],
      ),
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
