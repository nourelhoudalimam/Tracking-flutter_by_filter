/*import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/MapByFilter.dart';
import 'package:my_api/View/MapWidget.dart';

class Menu extends StatefulWidget {
     ApiService apiService = ApiService("NourelHoudaLimam/24051999/09892244");

 Menu({required this.apiService}) ;

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<Menu> {

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
        builder: (context) => MapByFilter(apiService: widget.apiService),
      ),
    );              },
              child: Text('Get your device by filter'),
            ),
            SizedBox(height: 20),
        /*    ElevatedButton(
              onPressed: () {
                  Navigator.pushReplacement(
      context,
   MaterialPageRoute(
        builder: (context) => MapWidget(apiService: widget.apiService),
      ),
    );
                // Action à effectuer lors du clic sur le bouton "Signup"
              },
              child: Text('Get your device by code'),
            ),*/
          ],
        ),
      ),
    );
  }
}
*/