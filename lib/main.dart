import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() => runApp(MyApp());

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
  List<String> tasks = new List();
  List<String> archivedTasks = new List();

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
                                                                        tasks.add(textController.text);
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
    // final List<ListTile> tiles = task ?? task.map((value) {
    //   return new ListTile(title: new Text(value));
    // });
    final Iterable<Slidable> tiles = tasks.map((value) {
      return new Slidable(
        delegate: new SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,
        child: new Container(
          color: Colors.white,
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundColor: Colors.green,
              child: new Text("${tasks.indexOf(value) + 1}"),
              foregroundColor: Colors.white,
            ),
            title: new Text(value)
          ),
        ),
        actions: <Widget>[
          new IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () => _archiveTask(value),
          ),
        ],
      );
    });
    final List<Widget> divided = ListTile.divideTiles(
                                      context: context, 
                                      tiles: tiles)
                                      .toList();
    return new ListView(children: divided);
  }

  void _archiveTask(final String taskName) {
    setState(() {
      archivedTasks.add(taskName);
      tasks.remove(taskName);
    });
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
