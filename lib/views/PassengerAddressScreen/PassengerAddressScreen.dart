import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';

import 'package:beco_driver/views/TripInfoScreen/TripInfoScreen.dart';

class PassengerAddressScreen extends StatefulWidget {
  PassengerAddressScreen({Key? key}) : super(key: key);

  @override
  _PassengerAddressScreenState createState() => _PassengerAddressScreenState();
}

class _PassengerAddressScreenState extends State<PassengerAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
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
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthMargin * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                  ),
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
                  Text('De Av. da Universidade, 2710',
                      style: AppTextStyles.montserrat14MediumDark),
                  Text('para Avenida 13 de Maio, 2081',
                      style: AppTextStyles.montserrat10MediumGrey),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Color(0xffD0D2DA)),
                  ),
                  Text('De Avenida 13 de Maio, 2081',
                      style: AppTextStyles.montserrat14MediumDark),
                  Text('para Rua Jorge Dumar, 1703',
                      style: AppTextStyles.montserrat10MediumGrey),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Color(0xffD0D2DA)),
                  ),
                  Text('De Rua Jorge Dumar, 1703',
                      style: AppTextStyles.montserrat14MediumDark),
                  Text('para Av. Washington Soares, 1321',
                      style: AppTextStyles.montserrat10MediumGrey),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Color(0xffD0D2DA)),
                  ),
                  Text('De Av. Washington Soares, 1321',
                      style: AppTextStyles.montserrat14MediumDark),
                  Text('para Av. Santos Dumont, 3131',
                      style: AppTextStyles.montserrat10MediumGrey),
                  SizedBox(height: 5),
                  SizedBox(height: 30),
                ],
              ),
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
                            builder: (context) => TripInfoScreen()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
