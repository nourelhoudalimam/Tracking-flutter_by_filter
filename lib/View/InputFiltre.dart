/*
import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/Loading%20copy%203.dart';


class inputFiltre extends StatefulWidget {
//  final ApiService apiService;

 

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<inputFiltre> {

String filterValue='';
  final formField=GlobalKey<FormState>();
  final filterController=TextEditingController();
  
bool passToggle=true;
  final ApiService apiService = ApiService("NourelHoudaLimam/24051999/09892244"); // Remplacez "votre_clé_secrète" par votre clé secrète réelle

 

 
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     //   apiService = ApiService("NourelHoudaLimam/24051999/09892244"); // Replace with your actual secret key

  }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(

    appBar: AppBar(title: Text("Search by Filter"),
    centerTitle: true,),
    body:SingleChildScrollView(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 60),
    child: Form(
      key:formField,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    SizedBox(height: 50,),

  TextFormField(
      controller: filterController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Filter",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.filter_2),
    ),
        validator:(value) {
bool usernameValid = RegExp(r'^[a-zA-Z0-9._%+-]').hasMatch(value!);

          if(value.isEmpty){return "Enter Filter";}
       else if(!usernameValid ||  (filterController.text.length >20 &&filterController.text.length<3)){
          return "Enter valid Filter";
        }
        }

),
        SizedBox(height: 20,),

  
     

  
  MaterialButton(
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                
                color:Colors.blue
                , onPressed: () async {
                  if (formField.currentState!.validate()) {
                   filterValue = filterController.text;
              Navigator.pop(context); // Pop the inputFiltre screen


Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingPagesCopy2(apiService: apiService,filterValue: filterValue),
      ),
    );

                    
                  }   }
                  ,
child:Text("Get Chauffeurs",style:TextStyle(color:Colors.white)), ),



   ]
    
    ,)),),)
   );

  }

  }
  */