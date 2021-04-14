import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './SignUp.dart';
import './HomePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email;
  String _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen(
      (user) {
        if (user != null) {
          print(user);
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

  login() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
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
                child: Text("ok"))
          ],
        );
      },
    );
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
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
              image: AssetImage("images/1.jpg"),
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

              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(10.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            style: TextStyle(
                                fontSize: 20.0,
                                height: 1.0,
                                color: Colors.blueGrey),
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
                                      color: Colors.lightGreen, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input),
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: TextFormField(
                            style: TextStyle(
                                fontSize: 20.0,
                                height: 1.0,
                                color: Colors.blueGrey),
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
                                      color: Colors.lightGreen, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                prefixIcon: Icon(Icons.lock)),
                            obscureText: true,
                            onSaved: (input) => _password = input),
                      ),
                      SizedBox(height: 20.0),
                      MaterialButton(
                        onPressed: login,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF37BE74), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  child: Text(
                    "I dont's have Account",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  onTap: () {
                    navigateToSignUp();
                  }),
              SizedBox(width: 15),
              IconButton(
                  icon: const Icon(Icons.home),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    navigateToHome();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
