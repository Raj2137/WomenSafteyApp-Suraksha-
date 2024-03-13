import 'dart:math';

import 'package:app/db/dbserverces.dart';
import 'package:app/model/contactsm.dart';
import 'package:app/widgets/home_widgets/customappbar.dart';
import 'package:app/widgets/home_widgets/customcar.dart';
import 'package:app/widgets/home_widgets/emergency.dart';
import 'package:app/widgets/home_widgets/safehome/safehome.dart';
import 'package:app/widgets/livesafe.dart';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 0;
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  _sendSms(String phoneNumber, String message) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  String _currentCity = "";
  checkLocationPermission() async {
    bool permissionGranted = await _requestLocationPermission();
    setState(() {
      _locationPermissionGranted = permissionGranted;
    });

    if (_locationPermissionGranted) {
      _getCurrentCity();
    }
  }

  void _getCurrentCity() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          _currentCity = placemark.locality ?? 'Unknown';
        });
        print(_currentCity);
      }
    } catch (e) {
      print('Error getting current city: $e');
    }
  }

  bool _locationPermissionGranted = false;
  Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('Current Location: $position');
      _curentPosition= position;
      _getCurrentAddress();
      // Handle the obtained location as needed
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  String currentCity = '';

  _getCurrentAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
        "${place.locality},${place.postalCode},${place.street},";
        print(_curentAddress);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }




getAndSendSms() async{
  List<TContact> contactList =
  await DatabaseHelper().getContactList();
  print(contactList.length);
  if (contactList.isEmpty) {
    Fluttertoast.showToast(
        msg: "emergency contact is empty");
  } else {
    String messageBody =
        "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}";

    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        _sendSms("${element.number}",
            "i am in trouble $messageBody");
      });
    } else {
      Fluttertoast.showToast(msg: "something wrong");
    }
  }
}

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();

    ///// shake feature..........
    ShakeDetector.autoStart(
      onPhoneShake: () {
        getAndSendSms();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );
        // Do stuff on phone shake
        
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    getRandomQuote(); // Optional: You can initialize qIndex here if needed.
  }

  getRandomQuote() {
    Random random = Random();

    setState(() {
      qIndex = random.nextInt(6);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomAppBar(
                quoteInd: qIndex,
                onTap: getRandomQuote,
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 10,
                child: Container(
                  color: Colors.grey.shade100,
                ),
              ),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                   SizedBox(height: 10),
                    
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                    "In Case Of Emergency Dial",
                    style:
                       TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                        ),
                        // textAlign: TextAlign.center,
            )
            ),
            
            Emergency(),
            SizedBox(height: 10),
            
             Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Explore your power",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold
                              ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
            
              
            SizedBox(height: 10),
            Customcarouel(),
            SizedBox(height: 10),

            Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                    "Explore LiveSafe",
                    style:
                       TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
            )
            ),
            SizedBox(height: 10),
            LiveSafe(),
            Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                    "SOS",
                    style:
                       TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
            )
            ),
            SizedBox(height: 10),
           
            SafeHome(),
            
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
