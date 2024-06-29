import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String message;
  String senderEmail;
  String senderUid;
  String receiverUid;
  Timestamp timestamp;

  Message(
    this.message,
    this.senderEmail,
    this.senderUid,
    this.receiverUid,
    this.timestamp,
  );

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "senderEmail": senderEmail,
      "senderUid": senderUid,
      "receiverUid": receiverUid,
      "timestamp": timestamp,
    };
  }
}
