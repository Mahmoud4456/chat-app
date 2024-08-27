

import 'package:flutter/material.dart';

import 'constants.dart';

class ChatBuble extends StatelessWidget {
   ChatBuble({
    super.key, required this.message,
  });
 final  message ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16,right: 28,bottom: 28, top: 28),
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
              topRight: Radius.circular(32),
            )),
        child: Text(
          message ?? "no message yet",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


class ChatBuble2 extends StatelessWidget {
  ChatBuble2({
    super.key, required this.message,
  });
  final  message ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:const EdgeInsets.only(left: 16,right: 28,bottom: 28, top: 28),
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
        decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            )),
        child: Text(
          message ?? "no message yet",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}