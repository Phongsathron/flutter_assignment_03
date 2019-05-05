import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskList extends StatelessWidget {
  bool doneTask;

  TaskList(this.doneTask);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('todo').where('done', isEqualTo:doneTask).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView(
                  children: snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
                return CheckboxListTile(
                  value: document['done'],
                  title: Text(document['title']),
                  onChanged: (bool value) {
                    this.changeTodoStatus(document.documentID, !document['done']);
                  },
                );
              }).toList());
          }
        } else {
          return Center(
            child: Text("No data found."),
          );
        }
      },
    );
  }

  void changeTodoStatus(String documentID, bool isDone) {
    final DocumentReference todoRef =
        Firestore.instance.document('todo/${documentID}');
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(todoRef);
      if (postSnapshot.exists) {
        await tx.update(todoRef, <String, dynamic>{'done': isDone});
      }
    });
  }
}
