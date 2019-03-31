import 'package:flutter/material.dart';

void main() => runApp(MyApp());
List<String> taskNames = new List();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  Future<String> _addTaskDialog(BuildContext context) async {
    return showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                  title: Center(child: new Text("Add task")),
                  content: Form(key: _formKey,
                                child: Column(mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                        Padding(padding: EdgeInsets.all(8.0),
                                                                child: TextField(decoration: new InputDecoration(labelText: "Task name", hintText: "eg. By milk, learn flutter, ..."),
                                                                controller: textController,)),
                                                        Padding(padding: EdgeInsets.all(8.0),
                                                                child: RaisedButton(
                                                                  child: Text("Submit"),
                                                                  color: Colors.green,
                                                                  textColor: Colors.white,
                                                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                                                  onPressed: () {
                                                                      setState(() {
                                                                        taskNames.add(textController.text);
                                                                        textController.clear();
                                                                        Navigator.pop(context);
                                                                      });
                                                                    },
                                                                  )
                                                                )
                                                          ]
                                )
                            )
              )
          );
  }

  Widget _buildListView(BuildContext context) {
    // final List<ListTile> tiles = taskNames ?? taskNames.map((value) {
    //   return new ListTile(title: new Text(value));
    // });
    final Iterable<ListTile> tiles = taskNames.map((value) {
      return new ListTile(title: new Text(value));
    });
    final List<Widget> divided = ListTile.divideTiles(
                                      context: context, 
                                      tiles: tiles)
                                      .toList();
    return new ListView(children: divided);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskDialog(context);
         },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
