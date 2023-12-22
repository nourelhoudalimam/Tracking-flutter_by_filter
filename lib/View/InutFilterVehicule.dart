/*import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/LoadingMapFilter.dart';

class inputFilterVehicule extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<inputFilterVehicule> {
  String filterValue = '';
  final formField = GlobalKey<FormState>();
  final filterController = TextEditingController();
  final ApiService apiService = ApiService("NourelHoudaLimam/24051999/09892244");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search device by filter"),
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
                  controller: filterController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Filter",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.filter_2),
                  ),
                  validator: (value) {
                    bool usernameValid = RegExp(r'^[a-zA-Z0-9._%+-]').hasMatch(value!);

                    if (value.isEmpty) {
                      return "Enter Filter";
                    } else if (!usernameValid) {
                      return "Enter valid Filter";
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
                      filterValue = filterController.text;
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingMapFilter(apiService: apiService, filterValue: filterValue),
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
*/