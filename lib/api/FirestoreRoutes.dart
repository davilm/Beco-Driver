import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addRoute(
  startTrip,
  endTrip,
  date,
  travelPrice,
  driverName,
  driverImageUrl,
  driverUid,
) async {
  CollectionReference routes = FirebaseFirestore.instance.collection('routes');

  await routes
      .add({
        "startTrip": startTrip,
        "endTrip": endTrip,
        "date": date,
        "price": travelPrice,
        "driverName": driverName,
        "driverImageUrl": driverImageUrl,
        "driverUid": driverUid,
      })
      .then((value) => print("Route Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
