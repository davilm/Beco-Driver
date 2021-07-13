import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beco_driver/controllers/directions_repository.dart';
import 'package:beco_driver/controllers/geocoding_repository.dart';
import 'package:beco_driver/controllers/geo_location_controller.dart';

import 'package:beco_driver/models/directions_model.dart';
import 'package:beco_driver/models/reverse_geocoding_model.dart';

const CameraPosition _initialCameraPosition =
    CameraPosition(target: LatLng(-12.0529923, -58.3138234), zoom: 4.0);

class MyMapWidget extends StatefulWidget {
  final String endTrip;
  final String resetInfo;
  final bool infoTripScreen;
  // final Function sendInfo;

  const MyMapWidget({
    required this.endTrip,
    required this.resetInfo,
    required this.infoTripScreen,
    // required this.sendInfo,
    Key? key,
  });

  @override
  State<StatefulWidget> createState() => MyMapWidgetState();
}

class MyMapWidgetState extends State<MyMapWidget> {
  static final LatLng center = const LatLng(-33.86711, 151.1947171);

  GoogleMapController? _googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;

  LatLng myPosition = LatLng(0, 0);
  late Marker marker;
  Directions? _info;

  var myAddress;
  var myCityName;
  var fullAddress;
  var routeDistance;
  var routeDuration;
  var directions;

  String startTrip = "";
  late Timestamp date;
  String price = "";
  String selectedRoute = "void";
  int myFlag = 0;

  @override
  void initState() {
    _addMyLocationMarker();
    if (widget.infoTripScreen) {
      _addDestinationMarker();
    }
    // super.dispose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    this._googleMapController = controller;
  }

  Future<void> _getMyAddress() async {
    var address = await GeocodingRepository().getAddress(latlng: myPosition);

    setState(() {
      myAddress = address.formattedAddress;
      myCityName = address.cityName;
    });
  }

  Future<ReverseGeocoding> _getLatLng(String pos) async {
    var latLng = await GeocodingRepository().getLatLng(address: pos);

    print("latLng: $latLng.latLng");
    return latLng;
  }

  LatLng midPoint(double lat1, double long1, double lat2, double long2) {
    return new LatLng((lat1 + lat2) / 2, (long1 + long2) / 2);
  }

  void _addDestinationMarker() async {
    if (widget.endTrip == 'void') {
      return;
    }
    var pos = await _getLatLng(widget.endTrip);

    LatLng endTripPosition = pos.latLng;

    final String markerIdVal = 'marker_id_2';

    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: endTripPosition,
      infoWindow:
          InfoWindow(title: widget.endTrip, snippet: 'Esse é seu destino'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      onTap: () {
        _onMarkerTapped(markerId);
      },
      onDragEnd: (LatLng position) {
        _onMarkerDragEnd(markerId, position);
      },
    );

    directions = await DirectionsRepository()
        .getDirections(origin: myPosition, destination: endTripPosition);

    _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: midPoint(
          myPosition.latitude,
          myPosition.longitude,
          endTripPosition.latitude,
          endTripPosition.longitude,
        ),
        zoom: 11.0,
      )),
    );

    setState(() {
      markers[markerId] = marker;
      _info = directions;
    });
    // widget.sendInfo(_info);
  }

  _addMyLocationMarker() async {
    final MarkerId markerId = MarkerId('marker_id_0');

    GeoLocationController().currentPosition().then((controller) => {
          myPosition = LatLng(
            controller.latitude,
            controller.longitude,
          ),
          marker = Marker(
            markerId: markerId,
            position: myPosition,
            infoWindow: InfoWindow(
                title: "Minha localização",
                snippet: 'Sua viagem começa a partir daqui'),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              _onMarkerTapped(markerId);
            },
            onDragEnd: (LatLng position) {
              _onMarkerDragEnd(markerId, position);
            },
          ),

          _getMyAddress(),

          // Get Directions
          setState(() {
            markers[markerId] = marker;
          }),
          _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: myPosition, zoom: 13.0)),
          ),
        });
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 66),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Old position: ${tappedMarker.position}'),
                  Text('New position: $newPosition'),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  errorSnack(message, color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        duration: Duration(seconds: 5),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // String reset = widget.resetInfo;

    // if (!widget.infoTripScreen || reset != 'continue') {
    //   reset = 'void';
    //   _addDestinationMarker();
    // }
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(markers.values),
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Color(0xff15192C),
                      width: 5,
                      points: _info!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
                // onLongPress: (LatLng pos) {
                //   _addDestinationMarker(pos);
                // },
              ),
              if (!widget.infoTripScreen)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff15192C),
                    foregroundColor: Colors.white,
                    onPressed: () => _addDestinationMarker(),
                    child: const Icon(Icons.center_focus_strong),
                  ),
                ),
              // if (widget.infoTripScreen)
              //   Positioned(
              //     top: 10,
              //     right: 10,
              //     child: FloatingActionButton(
              //       backgroundColor: Color(0xff15192C),
              //       foregroundColor: Colors.white,
              //       onPressed: () => _addDestinationMarker(),
              //       child: const Icon(Icons.center_focus_strong),
              //     ),
              //   ),
              if (_info != null)
                if (widget.resetInfo != 'void')
                  Positioned(
                    top: 45,
                    left: MediaQuery.of(context).size.width / 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xff15192C),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        '${_info!.totalDistance}, ${_info!.totalDuration}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
