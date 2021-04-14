import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelmemories/HomePage.dart';
import 'package:travelmemories/Login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email, _password, _name;

  checkAuthentification() async {
    _auth.authStateChanges().listen(
      (user) async {
        if (user != null) {
          Navigator.pushReplacementNamed(context, "/");
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  signUp() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          //UserUpdateInfo updateser = UserUpdateInfo();
          //updateuser.displayName = _name;
          //user.updateProfile(userUpdate);
          await _auth.currentUser.updateProfile(displayName: _name);
        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errormessage),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }

  navigateToLogIn() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  navigateToHome() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/signin.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              RichText(
                text: TextSpan(
                  text: 'Travel Memories',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(10.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            style: TextStyle(
                                fontSize: 20.0,
                                height: 1.0,
                                color: Colors.black),
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Invalid Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                prefixIcon: Icon(Icons.person)),
                            onSaved: (input) => _name = input),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            style: TextStyle(
                                fontSize: 20.0,
                                height: 1.0,
                                color: Colors.black),
                            validator: (input) {
                              if (input.isEmpty || !input.contains('@')) {
                                return 'Invalid email!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                            onSaved: (input) => _email = input),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            style: TextStyle(
                                fontSize: 20.0,
                                height: 1.0,
                                color: Colors.black),
                            validator: (input) {
                              if (input.isEmpty || input.length < 6) {
                                return 'Password should more than 6 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input),
                      ),
                      SizedBox(height: 20.0),

                      //Sign up button

                      MaterialButton(
                        onPressed: () {
                          signUp();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                  child: Text(
                    "I have an Account",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onTap: () {
                    navigateToLogIn();
                  }),
              SizedBox(width: 15),
              IconButton(
                  icon: const Icon(Icons.home),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    navigateToHome();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
