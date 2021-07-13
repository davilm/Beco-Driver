import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';

import 'package:beco_driver/views/HomeScreen/widgets/DrawerWidget.dart';
import 'package:beco_driver/views/PassengerAddressScreen/PassengerAddressScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: widthMargin),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widthMargin * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Minhas Viagens", style: AppTextStyles.upTitle),
                SizedBox(height: 5),
                Container(width: 30, height: 2.5, color: Color(0xff00B7FE)),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text("Hoje ", style: AppTextStyles.montserrat20BoldDark),
                    Text("Oct 14",
                        style: AppTextStyles.montserrat20RegularDark),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 4, color: Color(0xff00B7FE)),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PassengerAddressScreen(
                              selectedRoute: 'Gwo9mVet7JJMi2Je8yRw'),
                        ),
                      ),
                    },
                    child: Text("Iniciar Próxima viagem",
                        style: AppTextStyles.montserrat12MediumDark),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
