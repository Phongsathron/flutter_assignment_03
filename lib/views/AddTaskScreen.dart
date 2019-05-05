import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTaskScreenState();
  }
}

class AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Subject"),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Subject'),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please fill subject';
                    }
                  },
                  onSaved: (value) {
                    this._subject = value;
                  },
                  onFieldSubmitted: (value){
                    this._saveForm();
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Save"),
                        onPressed: () {
                          this._saveForm();
                        },
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _saveForm(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      Navigator.of(context).pop();
    }
  }
}
