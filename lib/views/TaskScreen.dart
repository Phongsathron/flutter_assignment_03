import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TaskList.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskScreenState();
  }
}

class TaskScreenState extends State<TaskScreen> {
  int _index = 0;
  bool getDoneTask = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        actions: <Widget>[
          actionButtons(context)
        ],
      ),
      body: TaskList(getDoneTask),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int index) {
          setState(() {
            this._index = index;
            switch (index) {
              case 0:
                getDoneTask = false;
                break;
              default:
                getDoneTask = true;
            }
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("Task")),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), title: Text("Complete"))
        ],
      ),
    );
  }

  Widget actionButtons(context) {
    switch (this._index) {
      case 0:
        return IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
        );
        break;
      case 1:
        return IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            this.deleteAllDoneTodo();
          },
        );
        break;
    }
  }

  void deleteAllDoneTodo() async {
    QuerySnapshot querys = await Firestore.instance.collection('todo').where('done', isEqualTo: true).getDocuments();
    querys.documents.forEach((document){
      final DocumentReference todoRef = Firestore.instance.document('todo/${document.documentID}');
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(todoRef);
        if (postSnapshot.exists) {
          await tx.delete(todoRef);
        }
      });
    });
  }
}
