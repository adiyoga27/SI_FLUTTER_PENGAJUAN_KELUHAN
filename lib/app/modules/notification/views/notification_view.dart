import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ppju/app/core/values/colors.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: C.primaryColor,
          title: const Text('NotificationView'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notifications")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            // if connection is waiting
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            QuerySnapshot querySnapshot = streamSnapshot.data as QuerySnapshot;

            return ListView.builder(
              itemCount: querySnapshot.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 30,
                        child: const Icon(
                          Icons.notifications,
                          size: 30,
                          color: Colors.blueGrey,
                        ),
                      ),
                      title: Text(
                        querySnapshot.docs[index]["title"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            querySnapshot.docs[index]["body"],
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          // SizedBox(height: 5),
                          // Text(
                          //   time,
                          //   style: TextStyle(
                          //     color: Colors.grey[500],
                          //   ),
                          // ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[400],
                      ),
                      onTap: () {
                        controller.redirectToDetail(
                            querySnapshot.docs[index]["data"]["id"]);
                        // navigate to notification details screen
                      },
                    ),
                  ),
                );

                // ListTile(
                //   title: Text(querySnapshot.docs[index]["title"]),
                //   subtitle: Text(querySnapshot.docs[index]["body"]),
                // );
              },
            );
          },
        ));
  }
}
