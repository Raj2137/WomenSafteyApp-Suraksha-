import 'package:app/utils/flutter_backgroundservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/db/sharedpreference.dart';
import 'package:app/parent/parentlogin.dart';
import 'package:app/utils/constrants.dart';
import 'package:app/child/bottompage.dart';
import 'package:app/widgets/loginscreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPrefference.init();
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: MySharedPrefference.getUserType(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data == ""){
            return LoginScreen();
          }
          if(snapshot.data=="child"){
            return BottomPage();
          }
          if(snapshot.data=="parent"){
            return ParentHomeScreen();
          }

          return progressIndicator(context);
        }
      )
    );
  }
}

