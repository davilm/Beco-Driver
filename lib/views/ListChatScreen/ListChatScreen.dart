import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';

import 'package:beco_driver/views/ListChatScreen/widgets/GetRoutePassengers.dart';

class ListChatScreen extends StatefulWidget {
  final String selectedRoute;

  ListChatScreen({
    required this.selectedRoute,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
      ),
      body: SafeArea(
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
                child: GetRoutePassengers(
                  selectedRoute: widget.selectedRoute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
