import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';
import 'components/chat_buble.dart';
import 'components/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static String id = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();

  //MessageServices messageServices = MessageServices();
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
   Object? email = ModalRoute.of(context)!.settings.arguments  ;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kImage,
              height: 60,
            ),
             const Text(
              "Chat",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: MessageServices().getDataMessageStream(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('---Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages found'));
                }
                List<MessageModel> messages = snapshot.data!;
                return ListView.builder(
                  reverse: true ,
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return email == messages[index].id ? ChatBuble(message: messages[index].messages) : ChatBuble2(message: messages[index].messages);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {

                FirebaseFirestore.instance
                    .collection("messages")
                    .add({"messages": data,
                  "CreatAt": DateTime.now(),
                "id": email
                });
                controller.clear();

                setState(() {}); // Refresh the UI
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: "Send Message",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _scrollDown() {
  //   scrollController.animateTo(
  //     0,
  //     curve: Curves.easeOut,
  //     duration: const Duration(seconds: 2),
  //   );
  // }
}

// import 'package:firebase_e1/models/message_model.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'components/chat_buble.dart';
// import 'components/constants.dart';
//
// class ChatScreen extends StatefulWidget {
//   ChatScreen({super.key});
//
//   static String id = "ChatScreen";
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//    CollectionReference message =
//    FirebaseFirestore.instance.collection(kMessagesCollection);
//   TextEditingController controller = TextEditingController();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: kPrimaryColor,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               kImage,
//               height: 60,
//             ),
//             Text(
//               "Chat",
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder<List<MessageModel>>(
//               future: messageSevices().getDataMessage(),
//               builder: (context, snapshot) {
//                 try {
//                   // print("=========${messageSevices().getDataMessage()}");
//                   print("-------------------${snapshot.data}");
//                   if (snapshot.hasData) {
//                     List<MessageModel> data = snapshot.data!;
//                     print("++++++$data");
//                     return ListView.builder(
//                       itemCount: data.length,
//                       itemBuilder: (context, index) {
//                         return ChatBuble(message: data[index].messages);
//                       },
//                     );
//                   }
//                 }catch(e){
//                   print("error is => $e");
//                 }
//                 return Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: TextField(
//               controller: controller,
//               onSubmitted: (data) {
//               //  message.add({"message": data});
//                 controller.clear();
//               },
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.send,
//                   color: kPrimaryColor,
//                 ),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16)),
//                 hintText: " Send Message ",
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:firebase_e1/models/message_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'components/chat_buble.dart';
// // import 'components/constants.dart';
// //
// // class ChatScreen extends StatelessWidget {
// //   ChatScreen({super.key});
// //
// //   static String id = "ChatScreen";
// //   CollectionReference message =
// //       FirebaseFirestore.instance.collection(kMessagesCollection);
// //   TextEditingController controller = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<QuerySnapshot>(
// //         future: message.get(),
// //         builder: (context, snapshot) {
// //           if (snapshot.hasData) {
// //            // var data = snapshot.data!.docs;
// //           //  var doc = data[index].data() as Map<String, dynamic>;
// //             // List<MessageModel> messageList = [];
// //             // final messages = snapshot.data!.docs;
// //             // for (var doc in messages) {
// //             //   final messager =
// //             //       doc.data() as Map<String, dynamic>; // <-- Notice this
// //             //   messageList.add(MessageModel.fromJson(messager["message"]));
// //             //
// //             // }
// //             print(snapshot.data!.docs);
// //             return Scaffold(
// //               appBar: AppBar(
// //                 automaticallyImplyLeading: false,
// //                 backgroundColor: kPrimaryColor,
// //                 title: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Image.asset(
// //                       kImage,
// //                       height: 60,
// //                     ),
// //                     Text(
// //                       "Chat",
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               body: Column(
// //                 children: [
// //                   Expanded(
// //                     child: ListView.builder(
// //                       itemCount: 20,
// //                       itemBuilder: (context, index) => ChatBuble(),
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: EdgeInsets.all(16),
// //                     child: TextField(
// //                       controller: controller,
// //                       onSubmitted: (data) {
// //                         message.add({
// //                           "message": data,
// //                         });
// //                         controller.clear();
// //                       },
// //                       decoration: InputDecoration(
// //                         suffixIcon: Icon(
// //                           Icons.send,
// //                           color: kPrimaryColor,
// //                         ),
// //                         border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(16)),
// //                         hintText: " Send Message ",
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           } else {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //         });
// //   }
// //
// //   Future<QuerySnapshot> getData() async {
// //     // Get docs from collection reference
// //     QuerySnapshot querySnapshot = await message.get();
// //     // Get data from docs and convert map to List
// //     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
// //
// //     print(allData);
// //     return querySnapshot;
// //   }
// // }
