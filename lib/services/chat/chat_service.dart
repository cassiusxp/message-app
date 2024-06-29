import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/domain/models/message.dart';

class ChatService {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getMessages(String targetUid) {
    final uids = [auth.currentUser!.uid, targetUid];
    uids.sort();
    final chatroomId = uids.join("_");

    return db
        .collection("chatrooms")
        .doc(chatroomId)
        .collection("messages")
        .orderBy(
          "timestamp",
          descending: false,
        )
        .snapshots();
  }

  Future<void> sendMessage(String message, String targetUid) async {
    final uids = [auth.currentUser!.uid, targetUid];
    uids.sort();
    final chatroomId = uids.join("_");
    await db.collection("chatrooms").doc(chatroomId).collection("messages").add(
          Message(
            message,
            auth.currentUser!.email!,
            auth.currentUser!.uid,
            targetUid,
            Timestamp.now(),
          ).toMap(),
        );
  }
}
