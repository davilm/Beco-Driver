import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beco_driver/core/core.dart';
import 'package:beco_driver/shared/widgets/ArrowButtonWidget.dart';
import 'package:intl/intl.dart';

class RouteCard extends StatefulWidget {
  final String startTrip;
  final String endTrip;
  final Timestamp date;
  final String travelPrice;

  RouteCard(
    this.startTrip,
    this.endTrip,
    this.date,
    this.travelPrice, {
    Key? key,
  }) : super(key: key);

  @override
  _RouteCardState createState() => _RouteCardState();
}

class _RouteCardState extends State<RouteCard> {
  @override
  Widget build(BuildContext context) {
    String numberOfDay = '';
    String month = '';

    void convertTimeStamp(Timestamp timestamp) {
      numberOfDay = DateFormat.d().format(timestamp.toDate());

      month = DateFormat.MMMM().format(timestamp.toDate());
      month = month.toUpperCase();
      month = month.substring(0, 3);
    }

    convertTimeStamp(widget.date);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff551FFF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: AppTextStyles.beVietnam12MediumWhite,
                ),
                Text(
                  numberOfDay,
                  style: AppTextStyles.beVietnam12BoldWhite,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.startTrip,
                style: AppTextStyles.montserrat12MediumDark,
              ),
              Text(
                widget.endTrip,
                style: AppTextStyles.montserrat12MediumDark,
              ),
            ],
          ),
          Expanded(
            child: SizedBox(),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text(
              "R\$ ${widget.travelPrice}",
              style: AppTextStyles.montserrat12MediumDark,
            ),
          ),
          ArrowButtonWidget(() => {}),
        ],
      ),
    );
  }
}
