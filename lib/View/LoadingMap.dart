// loading_page.dart

import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/MapWidget.dart';

class LoadingMap extends StatefulWidget {
  final ApiService apiService;
  final String codeValue;

 LoadingMap({required this.apiService, required this.codeValue});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingMap> {
  @override
  void initState() {
    super.initState();
    _handleLogin();
  }

  void _handleLogin() async {
    await Future.delayed(Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MapWidget(codeValue: widget.codeValue, apiService: widget.apiService),
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
