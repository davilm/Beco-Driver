import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';
import 'package:beco_driver/views/ListChatScreen/widgets/ListTileWidget.dart';

class ListChatScreen extends StatefulWidget {
  final String driverName;
  final String driverUid;
  final String firstPassenger;
  final String firstPassengerImageUrl;
  final String firstPassengerUid;
  final String secondPassenger;
  final String secondPassengerImageUrl;
  final String secondPassengerUid;
  final String thirdPassenger;
  final String thirdPassengerImageUrl;
  final String thirdPassengerUid;
  final String fourthPassenger;
  final String fourthPassengerImageUrl;
  final String fourthPassengerUid;

  ListChatScreen(
    this.driverName,
    this.driverUid,
    this.firstPassenger,
    this.firstPassengerImageUrl,
    this.firstPassengerUid,
    this.secondPassenger,
    this.secondPassengerImageUrl,
    this.secondPassengerUid,
    this.thirdPassenger,
    this.thirdPassengerImageUrl,
    this.thirdPassengerUid,
    this.fourthPassenger,
    this.fourthPassengerImageUrl,
    this.fourthPassengerUid, {
    Key? key,
  }) : super(key: key);

  @override
  _ListChatScreenState createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(20),
          child: IconButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: widthMargin),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthMargin * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chat", style: AppTextStyles.upTitle),
                    SizedBox(height: 5),
                    Container(
                      width: 30,
                      height: 2,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 30),
                    ListTileWidget(
                      widget.firstPassenger,
                      widget.driverName,
                      "Vou atrasar um pouco",
                      widget.firstPassengerImageUrl,
                      "3:30 AM",
                      1,
                      widget.driverUid,
                      widget.firstPassengerUid,
                      key: ValueKey(widget.firstPassengerUid),
                    ),
                    SizedBox(height: 15),
                    ListTileWidget(
                      widget.secondPassenger,
                      widget.driverName,
                      "Cheguei!",
                      widget.secondPassengerImageUrl,
                      "3:30 AM",
                      3,
                      widget.driverUid,
                      widget.secondPassengerUid,
                      key: ValueKey(widget.secondPassengerUid),
                    ),
                    SizedBox(height: 15),
                    ListTileWidget(
                      widget.thirdPassenger,
                      widget.driverName,
                      "Nova mensagem",
                      widget.thirdPassengerImageUrl,
                      "3:30 AM",
                      0,
                      widget.driverUid,
                      widget.thirdPassengerUid,
                      key: ValueKey(widget.thirdPassengerUid),
                    ),
                    SizedBox(height: 15),
                    ListTileWidget(
                      widget.fourthPassenger,
                      widget.driverName,
                      "Nova mensagem",
                      widget.fourthPassengerImageUrl,
                      "3:30 AM",
                      0,
                      widget.driverUid,
                      widget.fourthPassengerUid,
                      key: ValueKey(widget.fourthPassengerUid),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
