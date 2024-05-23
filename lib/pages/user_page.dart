import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tabungan/helper/helper_function.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              displayMessageToUser("something went wrong", context);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return Text("no data");
            }

            final users = snapshot.data!.docs;

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 25),
                  child: Row(
                    children: [BackButton()],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: users.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return ListTile(
                          title: Text(user['username']),
                          subtitle: Text(user['email']),
                        );
                      }),
                ),
              ],
            );
          }),
    );
  }
}
