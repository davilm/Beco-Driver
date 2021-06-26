import 'package:beco_driver/views/ChatScreen/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileWidget extends StatelessWidget {
  final String name;
  final String subTitle;
  final String imageUrl;
  final String time;
  final int notifications;
  final String driverUid;
  final String passengerUid;

  const ListTileWidget(
    this.name,
    this.subTitle,
    this.imageUrl,
    this.time,
    this.notifications,
    this.driverUid,
    this.passengerUid, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.white,
        radius: 25,
      ),
      title: Text(
        name,
        style: GoogleFonts.montserrat(
          color: Color(0xff15192C),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: GoogleFonts.montserrat(
          color: Color(0xff92959E),
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            time,
            style: GoogleFonts.montserrat(
              color: Color(0xff92959E),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: notifications != 0 ? Color(0xFFFF6A00) : Colors.white,
            ),
            child: Center(
              child: Text(
                notifications.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatScreen(name, driverUid, passengerUid, imageUrl, key: key),
          ),
        ),
      },
    );
  }
}
