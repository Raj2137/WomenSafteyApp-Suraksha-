import 'package:flutter/material.dart';
import 'widgets/home_widgets/customappbar.dart';
import 'widgets/home_widgets/customcar.dart';
import 'widgets/home_widgets/emergency.dart';
import 'widgets/home_widgets/safehome/safehome.dart';

import 'widgets/livesafe.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 0;

  @override
  void initState() {
    super.initState();
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
                        textAlign: TextAlign.center,
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
