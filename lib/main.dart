import 'package:flutter/material.dart';

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
    return new ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final item = tasks[index];
        return Dismissible(key: Key(item),
                          direction: DismissDirection.startToEnd,
                          child: ListTile(title: Text(item)),
                          background: Container(
                                        color: Colors.greenAccent, 
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Stack(
                                            children: <Widget>[
                                              Icon(Icons.archive, color: Colors.white),
                                              Padding(padding: EdgeInsets.fromLTRB(30, 2, 0, 0),
                                                      child: Text("Archive",style: TextStyle(color: Colors.white),),
                                              ),
                                            ],
                                          ),
                                        ),),
                          onDismissed: (direction) { 
                            _archiveTask(item);
                          
                            Scaffold.of(context).showSnackBar(
                              SnackBar(content: new Text("Task '$item' archived"), backgroundColor: Colors.green,)
                            );
                          });
      },
    );
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
      appBar: AppBar(
        title: Text('Todo App'), 
        actions: <Widget>[ 
            new IconButton(icon: const Icon(Icons.list, color: Colors.white,))
          ]),
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
