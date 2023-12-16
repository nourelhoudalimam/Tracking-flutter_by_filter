import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/MapByFilter.dart';

class LoadingMapFilter extends StatefulWidget {
  final ApiService apiService;
  final String filterValue;

 LoadingMapFilter({required this.apiService, required this.filterValue});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingMapFilter> {
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
        builder: (context) => MapByFilter(filterValue: widget.filterValue, apiService: widget.apiService),
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
