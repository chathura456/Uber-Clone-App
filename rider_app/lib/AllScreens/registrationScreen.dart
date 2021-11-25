import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllWidgets/progessDialog.dart';
import 'package:rider_app/main.dart';

class RegistrationScreen extends StatefulWidget {

  static const String idScreen = "register";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nametextEditingController= TextEditingController();

  TextEditingController emailtextEditingController= TextEditingController();

  TextEditingController phonetextEditingController= TextEditingController();

  TextEditingController passwordtextEditingController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Image(image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                "Register as a Rider",
                style: TextStyle(fontSize: 24.0,fontFamily: "Brand-Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nametextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailtextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phonetextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        labelText: "Phone",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordtextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      onPressed: (){
                        if(nametextEditingController.text.length<3){
                          displayToastMassage("Name must be atleast 3 characters", context);
                        }
                        else if(!emailtextEditingController.text.contains("@")){
                          displayToastMassage("Email address is not Valid", context);
                        }
                        else if(phonetextEditingController.text.isEmpty){
                          displayToastMassage("Phone Number is mandatory", context);
                        }
                        else if(passwordtextEditingController.text.length<6){
                          displayToastMassage("Password must be at least 5 characters", context);
                        }
                        else{
                          registerNewUser(context);
                        }

                      }, child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(fontSize: 18.0,fontFamily: "Brand-Bold"),
                        ),
                      ),
                    ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                    )
                  ],
                ),),

              FlatButton(onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
              },
                  child: Text(
                      "Already have an Account? Login Here",
                  ))
            ],
          ),
        ),
      ),
    );

  }

  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
  {
    showDialog(context: context,
      builder: (BuildContext context){
        return ProgessDialog(message: "registering, Please wait...",);
      },);

    final User? firebaseUser = (await _firebaseAuth.
    createUserWithEmailAndPassword(
        email: emailtextEditingController.text,
        password: passwordtextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMassage("Error : " + errMsg, context);
    })).user;

    if(firebaseUser!=null) //User Created
    {
      //save user info to database

      Map userDataMap= {
        "name" : nametextEditingController.text.trim(),
        "email" : emailtextEditingController.text.trim(),
        "phone" : phonetextEditingController.text.trim(),
      };

      userRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMassage("Congratulations, your account has been created!!", context);

      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    }
    else
      {
        Navigator.pop(context);
        //error occured - display error msg
        displayToastMassage("New User Accounthas not been created", context);
      }
  }
}

displayToastMassage(String massage, BuildContext){
  Fluttertoast.showToast(msg: massage);
}
