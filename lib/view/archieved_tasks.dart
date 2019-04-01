import 'package:flutter/material.dart';

class ArchivedTasksList extends StatefulWidget {
  final List<String> _archivedTasks;

  ArchivedTasksList({List<String> archivedTasks}) : this._archivedTasks = archivedTasks;

  @override
  State<StatefulWidget> createState() => _ArchivedTasksList();

}

class _ArchivedTasksList extends State<ArchivedTasksList> {

  ListTile buildTiles(int index, String taskName) => 
    ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          // decoration: BoxDecoration(
          //   border: Border(right: BorderSide(width: 1, color: Colors.white24))
          // ),
          child: Text("${index+1}", style: TextStyle(color: Colors.white),),
        ),
        title: Text(taskName, style: TextStyle(color: Colors.white),)
      );


  Card buildCard(int index, String taskName) => 
    Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(14, 55, 16, .9)),
        child: buildTiles(index, taskName),
      )
    );

  Widget buildBody() => 
    Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: this.widget._archivedTasks.length,
          itemBuilder: (BuildContext context, int index) {
            return buildCard(index, this.widget._archivedTasks[index]);
          },
        )
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archived tasks')),
      body: buildBody(),
    );
  }

}