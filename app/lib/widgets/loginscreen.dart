import 'package:flutter/material.dart';
import 'package:app/components/customtextflied.dart';
import 'package:app/components/primarybutton.dart';
import 'package:app/components/secondarybutton.dart';
import 'package:app/child/registerchild.dart';
import 'package:app/utils/constrants.dart';
import 'package:app/parent/parentregister.dart';


class LoginScreen extends StatefulWidget {
@override
 State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;
   _onSubmit() async {
    _formKey.currentState!.save();
      print(_formData['email']);
      print(_formData['password']);

   }
  @override
  // void initState() {
  //   super.initState();
  // }

Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            isLoading
                ? progressIndicator(context)
              : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "USER LOGIN",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(
                                      0xfffc3b77,
                                    )),
                              ),
                              Image.asset(
                                'assets/logo.png',
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  hintText: 'enter email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.person),
                                  onsave: (email) {
                                    _formData['email'] = email ?? "";
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty ||
                                        email.length < 3 ||
                                        !email.contains("@")) {
                                      return 'enter correct email';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'enter password',
                                  isPassword: isPasswordShown,
                                  prefix: Icon(Icons.vpn_key_rounded),
                                  validate: (password) {
                                    if (password!.isEmpty ||
                                        password.length < 7) {
                                      return 'enter correct password';
                                    }
                                    return null;
                                  },
                                  onsave: (password) {
                                    _formData['password'] = password ?? "";
                                  },
                                  suffix: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordShown = !isPasswordShown;
                                        });
                                      },
                                      icon: isPasswordShown
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility)),
                                ),
                                PrimaryButton(
                                    title: 'LOGIN',
                                    onPressed: () 
                                    {
                                      progressIndicator(context);
                                      if (_formKey.currentState!.validate()) {
                                        _onSubmit();
                                      }
                                    }
                                    ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forget Password?",
                                style: TextStyle(fontSize: 18),
                              ),
                              SecondaryButton(
                                  title: 'click here', onPressed: () {}),
                            ],
                          ),
                        ),
                        SecondaryButton(
                            title: 'Register as child',
                            onPressed: () {
                              goTo(context, RegisterChildScreen());
                            }),
                        SecondaryButton(
                            title: 'Register as Parent',
                            onPressed: () {
                              goTo(context, RegisterParentScreen());
                            }),
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