// loading_page.dart

import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';

import 'package:my_api/View/ListChauffeurperId.dart';


class LoadingPagesCopy1 extends StatefulWidget {
  final ApiService apiService;
  final String idValue; // Add this line to accept the filter value

  LoadingPagesCopy1({required this.apiService,required this.idValue});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPagesCopy1> {

  @override
  void initState() {
    super.initState();
    _handleLogin();
  }

  void _handleLogin() async {
    // Simulate a delay (you can replace this with an actual operation)
    await Future.delayed(Duration(seconds: 2));

    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ListChauffeurparId(apiService: widget.apiService,idValue: widget.idValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
