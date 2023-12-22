// loading_page.dart
/*
import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/ListChauffeurparFiltre.dart';


class LoadingPagesCopy2 extends StatefulWidget {
  final ApiService apiService;
  final String filterValue; // Add this line to accept the filter value

  LoadingPagesCopy2({required this.apiService,required this.filterValue});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPagesCopy2> {

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
        builder: (context) => ListChauffeurparFiltre(apiService: widget.apiService,filterValue: widget.filterValue),
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
*/