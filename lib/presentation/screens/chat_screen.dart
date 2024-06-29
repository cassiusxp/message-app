// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/services/chat/chat_service.dart';

class ChatScreen extends StatelessWidget {
  final String userUid;
  final String targetUid;
  const ChatScreen({super.key, required this.userUid, required this.targetUid});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(targetUid),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildChatInput(_controller)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    final _chatService = ChatService();
    return StreamBuilder(
      stream: _chatService.getMessages(targetUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map(
                (e) => _buildMessageWidgets(e),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageWidgets(QueryDocumentSnapshot doc) {
    final msg = doc.data() as Map<String, dynamic>;
    final alignment = msg["senderUid"] == FirebaseAuth.instance.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(msg["senderEmail"]),
          Text(msg["message"]),
        ],
      ),
    );
  }

  Widget _buildChatInput(TextEditingController _controller) {
    final _chatService = ChatService();
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: "Enter your message...",
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _chatService.sendMessage(_controller.text, targetUid);
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
