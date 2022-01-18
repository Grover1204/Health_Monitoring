import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeartInfo extends StatefulWidget {
  @override
  _HeartInfoState createState() => _HeartInfoState();
}

class _HeartInfoState extends State<HeartInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Heart Rate Sensor'),),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('health/8CtlQbZILnVmqPtnZK5o/HeartRate')
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
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.watch),
                  Text(' '),
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
                .collection('health/8CtlQbZILnVmqPtnZK5o/HeartRate')
                .add({'text': 'BPM -72'});
          }),
    );
  }
}