import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ppju/app/core/values/colors.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: C.primaryColor,
          title: const Text('NotificationView'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: controller.collection
              .where('to', isEqualTo: box.read('user')['nik'].toString())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            // if connection is waiting
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (streamSnapshot.data == null) {
              return Center(
                child: Text("No data"),
              );
            }
            QuerySnapshot querySnapshot = streamSnapshot.data as QuerySnapshot;
            return ListView.builder(
              itemCount: querySnapshot.docs.length,
              itemBuilder: (context, index) {
                List readers =
                    (querySnapshot.docs[index]['read_by'] ?? []) as List;

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: !readers
                                .contains(box.read('user')['nik'].toString())
                            ? Colors.blue[50]
                            : Colors.white,
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
                        controller.collection
                            .doc(querySnapshot.docs[index].id)
                            .update({
                          "read_by": [box.read('user')['nik'].toString()],
                        });
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
