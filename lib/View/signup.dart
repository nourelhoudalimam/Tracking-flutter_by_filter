import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_api/Controller/apiController.dart';
import 'package:my_api/View/login.dart';
import 'package:my_api/main.dart';

class SignUp extends StatefulWidget {
//  final ApiService apiService;

  SignUp();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<SignUp> {


  final formField=GlobalKey<FormState>();
   final fullnameController=TextEditingController();
  final usernameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final filterController=TextEditingController();
bool passToggle=true;
  String selectedRole = ''; // Default role

  bool isLoading = false;
late apiController controller;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
      //  apiService = ApiService("NourelHoudaLimam/24051999/09892244"); // Replace with your actual secret key

  }

      Future<void> signUp() async {
  final Set<String> selectedRolesSet = {selectedRole};

    const url = 'http://35.180.211.234:1111/cubeitcorp/navitrack-authentication/signup'; // Replace with your actual API endpoint
    final Map<String, dynamic> userData = {
      'fullname': fullnameController.text,
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'filter': filterController.text,
      'roles': selectedRolesSet.toList(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful signup
        print('Signup successful');
          Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => login(),
      ),
    ); 
        // You may navigate to the next screen or handle the success accordingly
        
      } else {
         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Signup failed: ${response.reasonPhrase}')),
                        );
        // Signup failed
        print('Signup failed: ${response.statusCode}');
        print('Response body: ${response.body}');

        // Handle the failure, show an error message, etc.
      }
    } catch (error) {
         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error during signup: $error')),
                        );
      // An error occurred during the request
            print('Error during signup: $error');

      // Handle the error, show an error message, etc.
    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(

    appBar: AppBar(title: Text("Sign up page",style:TextStyle(color: Colors.white)),
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
      controller: fullnameController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Fullname",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.abc),
    ),
        validator:(value) {
bool fullnameValid = RegExp(r'^[a-zA-Z]{3,40}$').hasMatch(value!);

          if(value.isEmpty ){return "Enter Fullname";}
       else if(!fullnameValid || (fullnameController.text.length<3 && fullnameController.text.length >40)){
          return "Enter valid Fullname";
        }
        }

),        SizedBox(height: 20,),
 TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Username",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.supervised_user_circle),
    ),
        validator:(value) {
bool usernameValid = RegExp(r'^[a-zA-Z0-9._%+-]{3,20}$').hasMatch(value!);

          if(value.isEmpty){return "Enter Username";}
       else if(!usernameValid || (usernameController.text.length<3 && usernameController.text.length >20)){
          return "Enter valid username";
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
       else if(!emailValid || (emailController.text.length >50)){
          return "Enter valid email";
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
    bool passwordValid = RegExp(r'^[a-zA-Z0-9._%+-]{6,40}$').hasMatch(value!);

          if(value!.isEmpty){return "Enter password";}
        
        else if(!passwordValid||(passwordController.text.length<6 && passwordController.text.length>40) ){
          return "Password length should be more than 6 characters and less than 40 characters";
        }
        }    ),
            SizedBox(height: 20,),
TextFormField(
      controller: filterController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Filter",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.filter_2),
    ),
        validator:(value) {
bool filterValid = RegExp(r'^[a-zA-Z0-9._%+-]{5,50}$').hasMatch(value!);

          if(value.isEmpty){return "Enter Filter";}
       else if(!filterValid || (filterController.text.length >50 &&filterController.text.length<5)){
          return "Enter valid filter";
        }
        }

),
        SizedBox(height: 20),
         Text(
      "Role", // Add the title here
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
        DropdownButton<String>(
          
            value:selectedRole,
            onChanged: (String? newValue) {
              setState(() {
                selectedRole = newValue!;
                
              });
            },
            items: <String>['','ROLE_USER', 'ROLE_ADMIN', 'ROLE_MODERATOR']
                .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                )
                .toList(),
            
          ),
 SizedBox(height: 20),

  MaterialButton(
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                
                color:const Color.fromARGB(255, 116, 18, 11)
                , onPressed: () async {
 if (formField.currentState!.validate()) {

  if (selectedRole.isEmpty) {
      setState(() {
        selectedRole = 'ROLE_USER';
      });
    
    }
    signUp();    
    //final  Map<String, dynamic> payload= await controller.payload(usernameController.text.toString(), passwordController.text.toString());

}else{
 ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign up failed. Please try again.')),);
    }
               
                  },
child:Text("Sign up",style:TextStyle(color:Colors.white)), ),



   ]
    
    ,)),),)
   );



  }
 


}