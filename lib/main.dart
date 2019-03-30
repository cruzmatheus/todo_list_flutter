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
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                  title: Center(child: new Text("Add task")),
                  content: Form(key: _formKey,
                                child: Column(mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                        Padding(padding: EdgeInsets.all(8.0),
                                                                child: TextFormField(decoration: new InputDecoration(hintText: "Task name"),)),
                                                        Padding(padding: EdgeInsets.all(8.0),
                                                                child: RaisedButton(
                                                                  child: Text("Submit"),
                                                                  color: Colors.green,
                                                                  textColor: Colors.white,
                                                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                                                  onPressed: () {
                                                                      if (_formKey.currentState.validate()) {
                                                                        _formKey.currentState.save();
                                                                      }
                                                                    },
                                                                  )
                                                                )
                                                          ]
                                )
                            )
              )
          );
         },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
