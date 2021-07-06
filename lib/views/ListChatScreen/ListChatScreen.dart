import 'package:beco_driver/views/ListChatScreen/widgets/GetRoutePassengers.dart';
import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';

class ListChatScreen extends StatefulWidget {
  ListChatScreen({Key? key}) : super(key: key);

  @override
  _ListChatScreenState createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Scaffold(
      backgroundColor: Colors.white,
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
          child: Padding(
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
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: GetRoutePassengers(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
