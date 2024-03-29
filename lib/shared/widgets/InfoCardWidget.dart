import 'package:flutter/material.dart';

import 'package:beco_driver/core/app_text_styles.dart';

class InfoCardWidget extends StatefulWidget {
  final String title;
  final String image;

  InfoCardWidget(this.title, this.image);

  @override
  _InfoCardWidgetState createState() => _InfoCardWidgetState();
}

class _InfoCardWidgetState extends State<InfoCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(widget.image),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: AppTextStyles.text14,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
