import 'package:beco_driver/views/TripInfoScreen/TripInfoScreen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beco_driver/views/PassengerAddressScreen/widgets/PassengersAddressWidget.dart';

class TripInfoBuilder extends StatefulWidget {
  final String selectedRoute;

  TripInfoBuilder({
    required this.selectedRoute,
    Key? key,
  }) : super(key: key);

  @override
  State<TripInfoBuilder> createState() => _TripInfoBuilderState();
}

class _TripInfoBuilderState extends State<TripInfoBuilder> {
  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');

    // String _loadCurrentUser() {
    //   final _auth = FirebaseAuth.instance;

    //   final currentUser = _auth.currentUser;
    //   return currentUser!.uid;
    // }

    // String driverUid = _loadCurrentUser();

    return Container(
      child: FutureBuilder<DocumentSnapshot>(
        future: routes.doc(widget.selectedRoute).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong $snapshot.error"));
          }

          try {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return TripInfoScreen(
              myCityName: data['startTrip'],
              endTrip: data['endTrip'],
              travelPrice: data['price'].toString(),
              date: data['date'],
              selectedRoute: widget.selectedRoute,
              key: ValueKey(data['passengersList']),
            );
          } catch (e) {
            return Scaffold(
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
                body: Center(child: Text("nenhuma rota encontrada")));
          }
        },
      ),
    );
  }
}
