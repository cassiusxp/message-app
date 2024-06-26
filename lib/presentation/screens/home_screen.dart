// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/services/auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          _auth.auth.currentUser!.email!,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.auth.signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: _buildUserListWidget(),
    );
  }

  Widget _buildUserListWidget() {
    final _db = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: _db.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>(
                (e) => _buildUserTile(e),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildUserTile(QueryDocumentSnapshot doc) {
    final user = doc.data() as Map<String, dynamic>;
    if (FirebaseAuth.instance.currentUser!.email != user["email"]) {
      return ListTile(
        title: Text(
          user["email"],
        ),
        onTap: () {},
      );
    } else {
      return const SizedBox();
    }
  }
}
