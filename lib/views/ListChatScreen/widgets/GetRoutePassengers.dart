import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beco_driver/views/ListChatScreen/widgets/ListTileWidget.dart';

class GetRoutePassengers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');

    final String selectedRoute = "Gwo9mVet7JJMi2Je8yRw";

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

          try {
            return ListView.builder(
              itemCount: data['passengersList'].length,
              itemBuilder: (context, index) => ListTileWidget(
                data['passengersList'][index]['name'],
                data['driverName'],
                "Envie uma mensagem!",
                data['passengersList'][index]['imageUrl'],
                "3:30 AM",
                1,
                data['driverUid'],
                data['passengersList'][index]['uid'],
                key: ValueKey(data['passengersList']),
              ),
            );
          } catch (e) {
            return Center(child: Text("nenhum passageiro"));
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
