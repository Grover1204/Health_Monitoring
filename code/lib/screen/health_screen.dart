import 'package:flutter/material.dart';
//  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user2/widgets/heart_info.dart';
import 'package:user2/widgets/temp_info.dart';

class UserAuth extends StatelessWidget {

  void selectbuttonTemp(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return TempInfo();
    }));
  }
  void selectbuttonHeart(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return HeartInfo();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Monertoring'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.help,color: Theme.of(context).accentColor,),
                           SizedBox(
                            width: 10,
                          ),
                          Text('Help'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.exit_to_app,color: Theme.of(context).accentColor),
                          SizedBox(
                            width: 7,
                          ),
                          Text('Logout'),
                        ],
                      ),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
            Card(
              elevation: 30,
              margin: EdgeInsets.all(20),
              color: Colors.blue[200],
              child:   InkWell(
            onTap: () => selectbuttonTemp(context),
            splashColor: Colors.pink,
                child: Container(
                  alignment:Alignment.center ,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '1. Temperature Sensor',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // color: Theme.of(context).primaryIconTheme.color,decorationColor: Colors.black,
                      ),
                    )),
              ),
            ),
          Card(
              elevation: 30,
              margin: EdgeInsets.all(20),
              color: Colors.blue[200],
            child:  InkWell(
            onTap: () => selectbuttonHeart(context),
            splashColor: Colors.pink,
              child: Container(
                 alignment:Alignment.center ,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                child: Text(
                  '2. Heart Rate Sensor',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    // color: Theme.of(context).primaryIconTheme.color,
                  ),
                ),
              ),
            ),
          ),
        ],
        
      ),
    );
  }
}
