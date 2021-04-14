import 'HomeBody.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  String name, email;
  bool isloggedin = false;
  bool isSwitched = false;

//this is for user who not given email and password then we will not show him home page and send him on start().
  checkAuthentification() {
    _auth.authStateChanges().listen(
      (user) {
        if (user == null) {
          Navigator.of(context).pushReplacementNamed("Start");
        }
      },
    );
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(
        () {
          this.user = firebaseUser;
          this.isloggedin = true;
          this.name = user.displayName;
          this.email = user.email;
        },
      );
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Travel Memories",
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                SizedBox(width: 20),
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.blue,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ])),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.blue,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  children: <Widget>[
                    Text("${this.name}",
                        style: TextStyle(fontSize: 25, fontFamily: 'Pacifico')),
                    SizedBox(height: 6),
                    Text("${this.email}",
                        style: TextStyle(fontSize: 20, color: Colors.black45)),
                  ],
                ),
              ]),
            ),
            /*  UserAccountsDrawerHeader(
              accountName:
                  Text("${user.displayName}", style: TextStyle(fontSize: 20)),
              accountEmail:
                  Text("${user.email}", style: TextStyle(fontSize: 20)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ), */
            Divider(
              height: 1,
              thickness: 1,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Profile", style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.person),
                    onTap: () {
                      //Navigator.of(context).pop();
                      //Navigator.of(context).push(MaterialPageRoute(
                      //builder: (BuildContext context) => NewPage("Page two")));
                    },
                  ),
                  ListTile(
                    title: Text("Explor All Memories",
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.explore),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("DarkMode", style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.dark_mode),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Favorite", style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.favorite),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Support", style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.support_agent),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("SignOut", style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.assignment_ind_outlined),
                    onTap: () {
                      Navigator.of(context).pop();
                      signOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: !isloggedin ? CircularProgressIndicator() : Body(),

        ///this widget we created to body of homepage in homebody.dart
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.home_filled),
              onPressed: () {},
            ),
            SizedBox(width: 30),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            SizedBox(width: 40),
            IconButton(icon: Icon(Icons.post_add_rounded), onPressed: () {}),
            SizedBox(width: 40),
            IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
            SizedBox(width: 30),
            IconButton(icon: Icon(Icons.map), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
