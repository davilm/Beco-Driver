import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beco_driver/views/ListChatScreen/ListChatScreen.dart';
import 'package:beco_driver/views/Splashscreen/Splashscreen.dart';

class GetRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');

    final String selectedRoute = "Gwo9mVet7JJMi2Je8yRw";
    final String driverUid = "pNKw0MEwouc2ajzaXeYd";

    return FutureBuilder<DocumentSnapshot>(
      future: routes.doc(selectedRoute).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          String firstPassenger = data["passengers"]["firstPassenger"]["name"];
          String firstPassengerImageUrl =
              data["passengers"]["firstPassenger"]["imageUrl"];
          String firstPassengerUid =
              data["passengers"]["firstPassenger"]["uid"];

          String secondPassenger =
              data["passengers"]["secondPassenger"]["name"];
          String secondPassengerImageUrl =
              data["passengers"]["firstPassenger"]["imageUrl"];

          String secondPassengerUid =
              data["passengers"]["secondPassenger"]["uid"];

          String thirdPassenger = data["passengers"]["thirdPassenger"]["name"];
          String thirdPassengerImageUrl =
              data["passengers"]["firstPassenger"]["imageUrl"];

          String thirdPassengerUid =
              data["passengers"]["thirdPassenger"]["uid"];

          String fourthPassenger =
              data["passengers"]["fourthPassenger"]["name"];
          String fourthPassengerImageUrl =
              data["passengers"]["firstPassenger"]["imageUrl"];

          String fourthPassengerUid =
              data["passengers"]["fourthPassenger"]["uid"];

          return ListChatScreen(
            driverUid,
            firstPassenger,
            firstPassengerImageUrl,
            firstPassengerUid,
            secondPassenger,
            secondPassengerImageUrl,
            secondPassengerUid,
            thirdPassenger,
            thirdPassengerImageUrl,
            thirdPassengerUid,
            fourthPassenger,
            fourthPassengerImageUrl,
            fourthPassengerUid,
          );
        }

        return SplashScreen();
      },
    );
  }
}
