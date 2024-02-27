import 'package:flutter/material.dart';
import 'livelocation/busstation.dart';
import 'livelocation/hospital.dart';
import 'livelocation/pharmacy.dart';
import 'livelocation/policestation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LiveSafe extends StatelessWidget {
  
  static Future<void> openMap(String location) async {
    String googleUrl= 'https://www.google.com/maps/search/?api=1&query=$location';
    final Uri _url = Uri.parse(googleUrl);
      
      try {
        await launchUrl(_url);
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'something went wrong! Call Emergency Number'
        );
      }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      // Stateless widget displays the provided text
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
           PoliceStationCard(onMapFunction: openMap),
           HospitalCard(onMapFunction: openMap),
           PharmacyCard(onMapFunction: openMap),
           BusStationCard(onMapFunction: openMap),
        ],
      ),
    );
  }
}