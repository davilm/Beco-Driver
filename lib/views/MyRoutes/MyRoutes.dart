import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';
import 'package:beco_driver/views/MyRoutes/widgets/GetAllRoutesInfo.dart';
import 'package:beco_driver/views/NewRoute/NewRoute.dart';

class MyRoutes extends StatefulWidget {
  MyRoutes({Key? key}) : super(key: key);

  @override
  _MyRoutesState createState() => _MyRoutesState();
}

class _MyRoutesState extends State<MyRoutes> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    final String title = "Minhas rotas";
    String driverUid = "pNKw0MEwouc2ajzaXeYd";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: Padding(
          padding: EdgeInsets.all(15),
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
        actions: [
          Container(
            margin: EdgeInsets.only(top: 20, right: 35, bottom: 23),
            width: 37,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff00B7FE),
            ),
            child: IconButton(
              onPressed: () => {
                FocusScope.of(context).unfocus(),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewRoute(),
                  ),
                ),
              },
              icon: Icon(
                Icons.add,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.only(left: widthMargin, top: 12),
          child: Padding(
            padding:
                EdgeInsets.only(left: widthMargin * 5, right: widthMargin * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.upTitle),
                SizedBox(height: 5),
                Container(
                  width: 30,
                  height: 2,
                  color: Colors.blue,
                ),
                SizedBox(height: 35),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: GetAllRoutesInfo(driverUid),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
