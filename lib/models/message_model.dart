import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_e1/screens/components/constants.dart';

class MessageModel {
  final String messages;
  final String id ;
  MessageModel({ required this.id,required this.messages});

  factory MessageModel.fromJson(json) {
    return MessageModel(
      id : json["id"],
      messages: json[kMessagesCollection] ?? "", // استخدم string فارغة إذا كانت القيمة null
    );
  }
}



class MessageServices {
  Stream<List<MessageModel>> getDataMessageStream() {
    return FirebaseFirestore.instance
        .collection("messages")
        .orderBy("CreatAt" , descending: true)
        .snapshots()
        .map((snapshot) {
      // print(" /////////${FirebaseFirestore.instance.collection("messages").snapshots()}");
      //  print("+++++++${snapshot.docs}");
      return snapshot.docs.map((doc) {
        final docData = doc.data();
        // print("---------$docData");
        if (docData["messages"] == null) {
          print("Warning: Null message found in document ${doc.id}");
        }
        return MessageModel.fromJson(docData);
      }).toList();
    });
  }
}




//
// class MessageModel{
//   final String messages;
//
//   MessageModel( {required this.messages});
//
//   factory MessageModel.fromJson( json){
//     return MessageModel(
//       messages: json["messages"],
//     );
//   }
// }




//
// class messageSevices{
//   Future <List<MessageModel>> getDataMessage() async{
//     final data =await FirebaseFirestore.instance.collection("messages").get();
//     final userMessage = data.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
//     print("=========${userMessage.toString()}");
//     //MessageModel message = MessageModel.fromJson(userMessage) ;
//     return userMessage;
//   }
// }