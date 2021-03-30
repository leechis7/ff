import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeWidget());
  }
}

class AppState {
  bool loading;
  FirebaseUser user;

  AppState(this.loading, this.user);
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final app = AppState(false, null);

  // @override
  // void initState() {
  //   super.initState();
  //   _delay();
  // }

  // _delay() {
  //   Future.delayed(Duration(seconds: 1), () {
  //     setState(() => app.loading = false);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (app.loading) return _loading();
    if (app.user == null) return _login();
    return _main();
  }

  Widget _loading() {
    return Scaffold(
        appBar: AppBar(title: Text('loading...')),
        body: Center(child: CircularProgressIndicator()));
  }

  Widget _login() {
    return Scaffold(
        appBar: AppBar(title: Text('login page')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text('login'),
                onPressed: () {
                  setState(() {
                    _signIn();
                  });
                })
          ],
        )));
  }

  Widget _main() {
    return Scaffold(
        appBar: AppBar(
          title: Text(app.user),
          actions: [
            IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  setState(() {
                    _signOut();
                  });
                })
          ],
        ),
        body: Center(child: Text('contents')));
  }

  Future<String> _signIn() async {
    setState(() {
      app.loading = true;
    });

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    print(user);

    setState(() {
      app.loading = false;
      app.user = user;
    });

    return 'success';
  }

  void _signOut() async {
    await _googleSignIn.signOut();
    setState(() {
      app.user = null;
    });
  }
}
