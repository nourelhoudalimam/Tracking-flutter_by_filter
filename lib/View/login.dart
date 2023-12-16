import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/Loading.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
//  final ApiService apiService;

  login();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<login> {


  final formField=GlobalKey<FormState>();
  final usernameController=TextEditingController();
  final passwordController=TextEditingController();
bool passToggle=true;
  final ApiService apiService = ApiService("NourelHoudaLimam/24051999/09892244"); // Remplacez "votre_clé_secrète" par votre clé secrète réelle

  bool isLogin= false;
 

 
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     //   apiService = ApiService("NourelHoudaLimam/24051999/09892244"); // Replace with your actual secret key

  }
   Future<void> _login() async {
isLogin=false;
  const String apiUrl =
      'http://35.180.211.234:1111/cubeitcorp/navitrack-authentication/signin';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'username': usernameController.text,
      'password': passwordController.text,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // Successful login 
    // Successful login 
     
    final Map<String, dynamic> data = json.decode(response.body);
    // Handle the response data, e.g., save authentication token
    print('Login successful: ${data['token']}');
     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoadingPages(apiService: apiService),
                          ),
                        );
    final Uri Url = Uri.parse('http://192.168.1.26:3000/jwt');
    final Map<String, dynamic> jwtToken = {
      'jwt': data['token']
    };
    final http.Response serverResponse = await http.post(
      Url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jwtToken),
    );

    if (serverResponse.statusCode == 200 || serverResponse.statusCode == 201) {
      print('jwt added successfully to server');
    } else {
      // Failed login
      print('Jwt not added : ${serverResponse.statusCode}');
      print('Response body: ${serverResponse.body}');
    }
  } else {
    // Failed login
    print('Login failed : ${response.statusCode}');
    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed. Please try again.')),
                        );
    print('Response body: ${response.body}');
  }
}

  @override
  Widget build(BuildContext context) {
   return Scaffold(

    appBar: AppBar(title: Text("Login page"),
    centerTitle: true,),
    body:SingleChildScrollView(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 60),
    child: Form(
      key:formField,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset("images/avatar.png", height:200,
    width:200),
    SizedBox(height: 50,),

  TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Username",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.supervised_user_circle),
    ),
        validator:(value) {
bool usernameValid = RegExp(r'^[a-zA-Z0-9._%+-]').hasMatch(value!);

          if(value.isEmpty){return "Enter Username";}
       else if(!usernameValid || (usernameController.text.length<3 && usernameController.text.length >20)){
          return "Enter valid username";
        }
        }

),
        SizedBox(height: 20,),

     TextFormField(
      controller: passwordController,
      obscureText: passToggle,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Password",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.lock),
    suffix:InkWell(
      onTap: (){
        setState(() {
          passToggle=!passToggle;
        }); },
        child:Icon(passToggle? Icons.visibility:Icons.visibility_off),

     
    )),
   validator:(value) {
          if(value!.isEmpty){return "Enter password";}
        
        else if(passwordController.text.length<6 && passwordController.text.length>40 ){
          return "Password length should be more than 6 characters and less than 40 characters";
        }
        }    ),
        SizedBox(height: 60,),

  
  MaterialButton(
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                
                color:Colors.blue
                , onPressed: () async {
                  if (formField.currentState!.validate()) {
                    _login();

                    


                    
                  }   }
                  ,
child:Text("Login",style:TextStyle(color:Colors.white)), ),



   ]
    
    ,)),),)
   );

  }

  }
  
 


