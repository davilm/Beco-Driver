import 'package:beco_driver/views/PassengerAddressScreen/widgets/GetCurrentRouteInfo.dart';
import 'package:beco_driver/views/PassengerAddressScreen/widgets/MyMapWidget.dart';
import 'package:beco_driver/views/TripInfoScreen/widgets/TripInfoBuilder.dart';
import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';

class PassengerAddressScreen extends StatefulWidget {
  final String selectedRoute;

  PassengerAddressScreen({
    required this.selectedRoute,
    Key? key,
  }) : super(key: key);

  @override
  _PassengerAddressScreenState createState() => _PassengerAddressScreenState();
}

class _PassengerAddressScreenState extends State<PassengerAddressScreen> {
  String endTrip = 'void';
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.2,
                child: MyMapWidget(
                  endTrip: endTrip,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    Center(
                      child: Text('Busque seus passageiros',
                          style: AppTextStyles.montserrat12MediumDark),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 1,
                            color: Color(0xffD0D2DA)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthMargin * 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: GetCurrentRouteInfo(
                            selectedRoute: widget.selectedRoute,
                            getAddress: (address) {
                              setState(() {
                                this.endTrip = address;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: widthMargin * 5,
              right: widthMargin * 5,
              bottom: 20,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff15192C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Iniciar viagem",
                    style: AppTextStyles.montserrat14SemiboldWhite,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripInfoBuilder(
                          selectedRoute: widget.selectedRoute,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
