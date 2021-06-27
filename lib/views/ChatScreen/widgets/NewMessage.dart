import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  final String driverName;
  final String driverUid;
  final String passengerUid;

  NewMessage(
    this.driverName,
    this.driverUid,
    this.passengerUid, {
    Key? key,
  }) : super(key: key);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  String driverUid = "pNKw0MEwouc2ajzaXeYd";
  String passengerUid = "JIbVoYwhRGVQs5AaEuOOBDBQU3J2";

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': widget.driverUid,
      'userName': widget.driverName,
      'driverUid': driverUid,
      'passengerUid': widget.passengerUid,
    });

    _enteredMessage = '';
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.38,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xffF4F4F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          setState(() {
            _enteredMessage = value;
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ),
      ),
    );
  }
}
