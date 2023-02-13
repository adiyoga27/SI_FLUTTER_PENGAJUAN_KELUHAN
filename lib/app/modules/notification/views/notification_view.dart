import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NotificationView'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notifications")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
            if (querySnapshot != null) {
              return ListView.builder(
                itemCount: querySnapshot.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = querySnapshot.docs[index];
                  var data = documentSnapshot.data();

                  return ListTile(
                    title: Text(data['title'].toString()),
                    subtitle: Text(data['description']),
                  );
                },
              );
            }
          },
        ));
  }
}
