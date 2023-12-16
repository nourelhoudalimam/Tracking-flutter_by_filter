import 'package:flutter/material.dart';
import 'package:my_api/View/login.dart';
import 'package:my_api/View/signup.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton "Login"
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => login(),
      ),
    );              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp(),
      ),
    );
                // Action à effectuer lors du clic sur le bouton "Signup"
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
