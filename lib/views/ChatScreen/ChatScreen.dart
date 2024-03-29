import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';

import 'package:beco_driver/views/ChatScreen/widgets/Messages.dart';
import 'package:beco_driver/views/ChatScreen/widgets/NewMessage.dart';

class ChatScreen extends StatefulWidget {
  final String passengerName;
  final String driverName;
  final String driverUid;
  final String passengerUid;
  final String imageUrl;

  ChatScreen(
    this.passengerName,
    this.driverName,
    this.driverUid,
    this.passengerUid,
    this.imageUrl, {
    Key? key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {
            Navigator.pop(context),
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthMargin * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.passengerName, style: AppTextStyles.upTitle),
                  SizedBox(height: 5),
                  Container(
                    width: 30,
                    height: 2,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Messages(
                      widget.driverUid,
                      widget.passengerUid,
                      widget.imageUrl,
                    ),
                  ),
                  NewMessage(
                    widget.driverName,
                    widget.driverUid,
                    widget.passengerUid,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
