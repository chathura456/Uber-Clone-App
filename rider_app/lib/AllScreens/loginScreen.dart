import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllScreens/registrationScreen.dart';
import 'package:rider_app/AllWidgets/progessDialog.dart';
import 'package:rider_app/main.dart';

class LoginScreen extends StatefulWidget {

  static const String idScreen = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailtextEditingController= TextEditingController();

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
              SizedBox(height: 35.0,),
              Image(image: AssetImage("images/logo.png"),
              width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                "Login as a Rider",
                style: TextStyle(fontSize: 24.0,fontFamily: "Brand-Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 1.0,),
                  TextField(
                    controller: emailtextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
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
                    controller: passwordtextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
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
                    onPressed: ()
                    {
                      if(!emailtextEditingController.text.contains("@")){
                        displayToastMassage("Email address is not Valid.", context);
                      }
                      else if(passwordtextEditingController.text.isEmpty){
                        displayToastMassage("Password is mandatory.", context);
                      }
                      else{
                        loginAndAuthUser(context);
                      }

                  },
                    child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        "Login",
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
                Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
              },
                  child: Text(
                "Do not have an Account? Register Here"
              ))
            ],
          ),
        ),
      ),
    );

  }

  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;

  void loginAndAuthUser(BuildContext context) async
  {
    showDialog(context: context,
        builder: (BuildContext context){
      return ProgessDialog(message: "Authenticating, Please wait...",);
        },);
    final User? firebaseUser = (await _firebaseAuth.
    signInWithEmailAndPassword(
    email: emailtextEditingController.text,
    password: passwordtextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMassage("Error : " + errMsg, context);
    })).user;

    if(firebaseUser!=null) //User Created
        {
      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
        if(snap.value!=null)
        {
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMassage("You are logged-in now!!", context);
        }
        else
          {
            Navigator.pop(context);
            _firebaseAuth.signOut();
            displayToastMassage("No records exists for this user. Please create new account", context);
          }
      });



    }
    else
    {
      //error occured - display error msg
      Navigator.pop(context);
      displayToastMassage("Error occured!! cannot be sign in", context);
    }
  }
}
