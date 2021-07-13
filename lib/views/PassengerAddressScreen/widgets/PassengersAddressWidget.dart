import 'package:flutter/material.dart';

import 'package:beco_driver/core/core.dart';

class PassengersAddressWidget extends StatelessWidget {
  final String name;
  final String destination;

  const PassengersAddressWidget(this.name, this.destination, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Busque $name ", style: AppTextStyles.montserrat10MediumGrey),
        SizedBox(height: 5),
        Text("$destination", style: AppTextStyles.montserrat14MediumDark),
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
