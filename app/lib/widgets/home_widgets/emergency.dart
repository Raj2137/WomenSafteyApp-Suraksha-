import 'package:flutter/material.dart';
import 'package:app/widgets/home_widgets/emergencies/police.dart';
import 'package:app/widgets/home_widgets/emergencies/ambulance.dart';
import 'package:app/widgets/home_widgets/emergencies/army.dart';
import 'package:app/widgets/home_widgets/emergencies/fire.dart';

class Emergency extends StatelessWidget {
  

  // Constructor
   const Emergency ({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
           PoliceEmergency(),
           AmbulanceEmergency(),
           FirebrigadeEmergency(),
           ArmyEmergency(),
        ],
      ),
    );
  }
}