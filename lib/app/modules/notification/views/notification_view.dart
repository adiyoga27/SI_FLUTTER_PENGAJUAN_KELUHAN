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
          builder: (context, snap) {
            // if connection is waiting
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            QuerySnapshot querySnapshot = snap.data as QuerySnapshot;

            return ListView.builder(
              itemCount: querySnapshot.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(querySnapshot.docs[index]["title"]),
                  subtitle: Text(querySnapshot.docs[index]["body"]),
                );
              },
            );
          },
        ));
  }
}
