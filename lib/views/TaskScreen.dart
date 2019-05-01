import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TaskScreenState();
  }
}

class TaskScreenState extends State<TaskScreen>{
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () {

            },
          )
        ],
      ),
      body: Center(
        child: Text("No data found."),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int index){
          setState(() {
            this._index = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Task")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            title: Text("Complete")
          )
        ],

      ),
    );
  }

}