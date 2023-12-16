import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/LoadingMap.dart';

class inputCode extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<inputCode> {
  String codeValue = '';
  final formField = GlobalKey<FormState>();
  final codeController = TextEditingController();
  final ApiService apiService = ApiService("NourelHoudaLimam/24051999/09892244");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search device by code"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            key: formField,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: codeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Code",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.filter_2),
                  ),
                  validator: (value) {
                    bool usernameValid = RegExp(r'^[a-zA-Z0-9._%+-]').hasMatch(value!);

                    if (value.isEmpty) {
                      return "Enter Code";
                    } else if (!usernameValid) {
                      return "Enter valid Code";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  minWidth: 500,
                  color: Colors.blue,
                  onPressed: () async {
                    if (formField.currentState!.validate()) {
                      codeValue = codeController.text;
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingMap(apiService: apiService, codeValue: codeValue),
                        ),
                      );
                    }
                  },
                  child: Text("Get Devices", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
