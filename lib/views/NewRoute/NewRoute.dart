import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:beco_driver/core/core.dart';
import 'package:beco_driver/api/FirestoreRoutes.dart';

class NewRoute extends StatefulWidget {
  NewRoute({Key? key}) : super(key: key);

  @override
  _NewRouteState createState() => _NewRouteState();
}

class _NewRouteState extends State<NewRoute> {
  bool babySeat = false;
  bool pickUpAtHhome = false;

  String startTrip = "";
  String endTrip = "";
  var date;
  String travelPrice = "";
  String driverName = "Jim Obrien";
  String driverImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/beco-9fab4.appspot.com/o/face-light.png?alt=media&token=ceaba8cb-80ec-4f20-a56f-976f16d22216";
  String driverUid = "pNKw0MEwouc2ajzaXeYd";

  Widget buildStartTrip() => TextFormField(
        style: AppTextStyles.beVietnam14SemiboldGrey,
        key: ValueKey("De"),
        decoration: InputDecoration(
          labelText: "De",
          hintText: 'Escolha a cidade',
        ),
        onChanged: (value) => startTrip = value,
      );

  Widget buildEndTrip() => TextFormField(
        style: AppTextStyles.beVietnam14SemiboldGrey,
        key: ValueKey("Para"),
        decoration: InputDecoration(
          labelText: "Para",
          hintText: 'Escolha a cidade',
        ),
        onChanged: (value) => endTrip = value,
      );

  @override
  Widget build(BuildContext context) {
    final double widthMargin = MediaQuery.of(context).size.width / 40;

    final String title = "Nova Rota";

    Future pickDate() async {
      final initialDate = DateTime.now();
      final initialTime = TimeOfDay.now();
      var newDate;
      var newTime;

      newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: DateTime(DateTime.now().year + 1),
      );

      if (newDate == null) return;

      newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (newTime == null) return;

      DateTime currentPhoneDate = new DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        newTime.hour,
        newTime.minute,
      );

      Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);

      setState(() {
        date = myTimeStamp;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
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
        actions: [
          Container(
            margin: EdgeInsets.only(top: 20, right: 35, bottom: 23),
            width: 37,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff00B7FE),
            ),
            child: IconButton(
              onPressed: () => {
                FocusScope.of(context).unfocus(),
                if (date != null)
                  {
                    addRoute(
                      startTrip,
                      endTrip,
                      date,
                      travelPrice,
                      driverName,
                      driverImageUrl,
                      driverUid,
                    ),
                    setState(() {
                      startTrip = "";
                      endTrip = "";
                      date = null;
                      travelPrice = "";
                    }),
                  }
              },
              icon: Icon(
                Icons.done,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.only(left: widthMargin, top: 12),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: widthMargin * 5,
                  right: widthMargin * 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.upTitle),
                    SizedBox(height: 5),
                    Container(
                      width: 30,
                      height: 2,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: buildStartTrip(),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: buildEndTrip(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Data da viagem',
                        style: AppTextStyles.beVietnam20SemiboldGrey,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff545FFF),
                          ),
                          child: TextButton(
                            onPressed: () => pickDate(),
                            child: Text(
                              date != null
                                  ? '${DateFormat('dd-MM-yyyy - kk:mm:a').format(date.toDate())}'
                                  : "Escolha uma data",
                              style: AppTextStyles.beVietnam12SemiboldWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          margin: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: Text(
                            'Assento de \nbebê',
                            style: AppTextStyles.beVietnam16SemiboldGrey,
                          ),
                        ),
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: babySeat
                                ? Color(0xff545FFF)
                                : Color(0xffF5F5F7),
                          ),
                          child: TextButton(
                            onPressed: () => setState(() {
                              babySeat = true;
                            }),
                            child: Text(
                              "Sim",
                              style: babySeat
                                  ? AppTextStyles.beVietnam12SemiboldWhite
                                  : AppTextStyles.beVietnam12SemiboldDark,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: babySeat
                                ? Color(0xffF5F5F7)
                                : Color(0xff545FFF),
                          ),
                          child: TextButton(
                            onPressed: () => setState(() {
                              babySeat = false;
                            }),
                            child: Text(
                              "Não",
                              style: babySeat
                                  ? AppTextStyles.beVietnam12SemiboldDark
                                  : AppTextStyles.beVietnam12SemiboldWhite,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          'R\$20+',
                          style: AppTextStyles.beVietnam14SemiboldGrey,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          margin: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: Text(
                            'Pegar\nem casa',
                            style: AppTextStyles.beVietnam16SemiboldGrey,
                          ),
                        ),
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: pickUpAtHhome
                                ? Color(0xff545FFF)
                                : Color(0xffF5F5F7),
                          ),
                          child: TextButton(
                            onPressed: () => setState(() {
                              pickUpAtHhome = true;
                            }),
                            child: Text(
                              "Sim",
                              style: pickUpAtHhome
                                  ? AppTextStyles.beVietnam12SemiboldWhite
                                  : AppTextStyles.beVietnam12SemiboldDark,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: pickUpAtHhome
                                ? Color(0xffF5F5F7)
                                : Color(0xff545FFF),
                          ),
                          child: TextButton(
                            onPressed: () => setState(() {
                              pickUpAtHhome = false;
                            }),
                            child: Text(
                              "Não",
                              style: pickUpAtHhome
                                  ? AppTextStyles.beVietnam12SemiboldDark
                                  : AppTextStyles.beVietnam12SemiboldWhite,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          'R\$20+',
                          style: AppTextStyles.beVietnam14SemiboldGrey,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextFormField(
                        style: AppTextStyles.beVietnam14SemiboldGrey,
                        key: ValueKey('preco'),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Preço da viagem",
                          hintText: 'Valor que cada passageiro irá pagar',
                        ),
                        onChanged: (value) => travelPrice = value,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
