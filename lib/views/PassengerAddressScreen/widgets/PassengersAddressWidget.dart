import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';

class PassengersAddressWidget extends StatelessWidget {
  final String current;
  final String destination;

  const PassengersAddressWidget(this.current, this.destination, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(current, style: AppTextStyles.montserrat14MediumDark),
        Text(destination, style: AppTextStyles.montserrat10MediumGrey),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Color(0xffD0D2DA)),
        ),
      ],
    );
  }
}
