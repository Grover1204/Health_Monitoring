import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class TempInfo extends StatefulWidget {
  @override
  _TempInfoState createState() => _TempInfoState();
}

class _TempInfoState extends State<TempInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature Sensor'),),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('health/8CtlQbZILnVmqPtnZK5o/temperature')
            .snapshots(),
        builder: (ctx, streamsnapshot) {
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final dataOfFirebase = streamsnapshot.data.docs;
          return ListView.builder(
            itemCount:
                dataOfFirebase.length, // streamSnashot.data.documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              child: 
              Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Icon(Icons.watch),
                  Text(dataOfFirebase[index]['text']),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('health/8CtlQbZILnVmqPtnZK5o/temperature')
                .add({'text': 'Object temp : 41.7  , Ambient temperature : 31.4'});
          }),
    );
  }
}