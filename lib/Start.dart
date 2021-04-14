import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  //for google sign in button
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  navigateToLogin() async {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    //as we used routing in main page insted of material page route we directly replace with name Login and we not need to inport login.dart
    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister() async {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
    Navigator.pushReplacementNamed(context, "SignUp");
  }

  navigateToHome() async {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/4.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            //Container(
            //child: Image(
            //image: AssetImage("images/start.jpg"),
            //fit: BoxFit.contain,
            //),
            //),

            SizedBox(height: 80),

            RichText(
              text: TextSpan(
                text: 'Welcome to Travel',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Memories',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Text(
              'You will able to share your travel memories to',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              ' the world through this platform.',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 150),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                            color: Colors.blue, style: BorderStyle.solid)),
                    onPressed: navigateToLogin,
                    color: Colors.lightBlue[50],
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.lightBlue, fontSize: 25),
                      ),
                    )),
                SizedBox(height: 20),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                            color: Colors.blue, style: BorderStyle.solid)),
                    onPressed: navigateToRegister,
                    color: Colors.lightBlue[50],
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.lightBlue, fontSize: 25),
                      ),
                    )),
              ],
            ),

            //this is the custom google signin button provided in flutter documents
            SizedBox(height: 10.0),
            // with custom text
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: googleSignIn,
            )
          ],
        ),
      ),
    );
  }
}
