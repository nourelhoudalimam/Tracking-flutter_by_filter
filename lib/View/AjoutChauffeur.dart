import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_api/Controller/apiController.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/InputCode.dart';
import 'package:my_api/View/InutFilterVehicule.dart';
import 'package:my_api/View/Loading%20copy%204.dart';
import 'package:my_api/View/Loading%20copy.dart';
enum FonctionChauffeur {
  CHAUFFEUR,
  CONVOYEUR,
}
class AjoutChauffeur extends StatefulWidget {
//  final ApiService apiService;

  AjoutChauffeur();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AjoutChauffeur> {

  TextEditingController idController = TextEditingController();
  TextEditingController filterController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController permisController = TextEditingController();
  TextEditingController teleController = TextEditingController();
  TextEditingController scoreController = TextEditingController();

  final formField=GlobalKey<FormState>();
  
  final ApiService apiService = ApiService("NourelHoudaLimam/24051999/09892244"); 
 
bool passToggle=true;
FonctionChauffeur selectedFonction = FonctionChauffeur.CHAUFFEUR;

  bool isLoading = false;
late apiController controller;
  int? _enteredNumber;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
      //  apiService = ApiService("NourelHoudaLimam/24051999/09892244"); // Replace with your actual secret key
 controller = Get.put(apiController());
    controller.initializeJWT();
  }

    Future<void> add() async {
  
  final String? jwt = await controller.getJwt();

    const url = 'http://35.180.211.234:1111/api/cubeIT/NaviTrack/rest/chauffeurs/create-one'; // Replace with your actual API endpoint
    final Map<String, dynamic> userData = {
         'filter': filterController.text,
   'fullname': fullnameController.text,
      'cin': cinController.text,
      'email': emailController.text,
      'permis': permisController.text,
      'tele': teleController.text,
      'fonction':selectedFonction.toString().split('.').last,
      'score_avg':_enteredNumber };
 try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization':'Bearer $jwt',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful signup
        print('chauffeur add successful');
      
        // You may navigate to the next screen or handle the success accordingly
        
      } else {
        // Signup failed
        print('adding failed: ${response.statusCode}');
        print('Response body: ${response.body}');

        // Handle the failure, show an error message, etc.
      }
    } catch (error) {
      // An error occurred during the request
      print('Error during add: $error');
      // Handle the error, show an error message, etc.
    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(

    appBar: AppBar(title: Text("Ajouter chauffeur page",style:TextStyle(color: Colors.white)),
    backgroundColor: Colors.deepOrangeAccent[700],
    centerTitle: true,),
    body:SingleChildScrollView(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 60),
    child: Form(
      key:formField,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
      controller: filterController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Filter",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.filter_2),
    ),
        validator:(value) {
bool filterValid = RegExp(r'^[a-zA-Z0-9._%+-]').hasMatch(value!);

          if(value.isEmpty){return "Enter Filter";}
       else if(!filterValid || (filterController.text.length >20 &&filterController.text.length<3)){
          return "Enter valid filter";
        }
        }

),
        SizedBox(height: 20),
TextFormField(
      controller: fullnameController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Fullname",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.abc),
    ),
        validator:(value) {
bool fullnameValid = RegExp(r'^[a-zA-Z]').hasMatch(value!);

          if(value.isEmpty ){return "Enter Fullname";}
       else if(!fullnameValid || (fullnameController.text.length<3 && fullnameController.text.length >40)){
          return "Enter valid Fullname";
        }
        }

),        SizedBox(height: 20,),
 TextFormField(
      controller: cinController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "CIN",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.supervised_user_circle),
    ),
        validator:(value) {
bool usernameValid = RegExp(r'^[0-9]').hasMatch(value!);

          if(value.isEmpty){return "Enter CIN";}
       else if(!usernameValid || (cinController.text.length<8 && cinController.text.length >10)){
          return "Enter valid CIN";
        }
        }

),
        SizedBox(height: 20,),
    TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(labelText: "Email",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.email),
    ),
        validator:(value) {
bool emailValid = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value!);

          if(value.isEmpty){return "Enter Email";}
       else if(!emailValid || (emailController.text.length >50 )){
          return "Enter valid email";
        }
        }

),
        SizedBox(height: 20,),
          TextFormField(
      controller: permisController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Permis",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.car_rental),
    ),
        validator:(value) {
bool emailValid = RegExp(r'^[a-zA-Z0-9._%+-]').hasMatch(value!);

          if(value.isEmpty){return "Enter Permis";}
       else if(!emailValid || (permisController.text.length >15 && permisController.text.length<5 )){
          return "Enter valid permis";
        }
        }

),
      
       
    
   
            SizedBox(height: 20,),
    TextFormField(
      controller: teleController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Telephone",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.phone),
    ),
        validator:(value) {
bool emailValid = RegExp(r'^[+0-9]').hasMatch(value!);

          if(value.isEmpty){return "Enter Telephone";}
       else if(!emailValid){
          return "Enter valid Telephone";
        }
        }

),
            SizedBox(height: 20,),
      
         Text(
      "Fonction", // Add the title here
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
      DropdownButton<FonctionChauffeur>(
  value: selectedFonction,
  onChanged: (FonctionChauffeur? newValue) {
    setState(() {
      selectedFonction = newValue!;
    });
  },
  items: FonctionChauffeur.values.map((FonctionChauffeur value) {
    return DropdownMenuItem<FonctionChauffeur>(
      value: value,
      child: Text(value.toString()),
    );
  }).toList(),
),SizedBox(height: 20),
  TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Score_avg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir un score_avg.';
                  }
                  return null;
                },
                onSaved: (value) {
                  // Convertir la chaîne en entier et le sauvegarder
                  _enteredNumber = int.parse(value!);
                },
              ),
 SizedBox(height: 20),

  MaterialButton(
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                
                color:const Color.fromARGB(255, 116, 18, 11)
                , onPressed: () async {
 if (formField.currentState!.validate()) {

 
 await add();

 ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('add chauffeur success.')),);}
else{
 ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('add chauffeur failed. Please try again.')),);
    }
               
                  },
child:Text("Add",style:TextStyle(color:Colors.white)), ),
SizedBox(height:20),
 MaterialButton(
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                
                color:const Color.fromARGB(255, 116, 18, 11)
                , onPressed: () async {

  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoadingPagesCopy(apiService: apiService),
                          ),
                        );


    },
               
                  
child:Text("Get chauffeur per filter",style:TextStyle(color:Colors.white)), ),
SizedBox(height:20),
 MaterialButton(
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                
                color:const Color.fromARGB(255, 116, 18, 11)
                , onPressed: () async {

  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoadingPagesCopy3(apiService: apiService)
                          ),
                        );

               
                  },
child:Text("Get chauffeur per id",style:TextStyle(color:Colors.white)), ),

SizedBox(height:20),
 MaterialButton(
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                
                color:const Color.fromARGB(255, 116, 18, 11)
                , onPressed: () async {

  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => inputCode()
                          ),
                        );

               
                  },
child:Text("Get Devices by code",style:TextStyle(color:Colors.white)), ),

 SizedBox(height:20),
 MaterialButton(
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                
                color:const Color.fromARGB(255, 116, 18, 11)
                , onPressed: () async {

  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => inputFilterVehicule()
                          ),
                        );

               
                  },
child:Text("Get Devices by filter",style:TextStyle(color:Colors.white)), ),  ]
    
    ,)),),)
   );



  }
 


}