
import 'package:flutter/material.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/Loading%20copy%202.dart';



class inputId extends StatefulWidget {
//  final ApiService apiService;

  inputId();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<inputId> {


  final formField=GlobalKey<FormState>();
  final idController=TextEditingController();
  
bool passToggle=true;
  final ApiService apiService = ApiService("NourelHoudaLimam/24051999/09892244"); // Remplacez "votre_clé_secrète" par votre clé secrète réelle
String idValue='';
 

 
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     //   apiService = ApiService("NourelHoudaLimam/24051999/09892244"); // Replace with your actual secret key

  }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(

    appBar: AppBar(title: Text("Search by ID"),
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
      controller: idController,
      keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: "Identifiant",
    border:OutlineInputBorder(),
    prefixIcon: Icon(Icons.filter_2),
    ),
        validator:(value) {
bool usernameValid = RegExp(r'^[0-9]').hasMatch(value!);

          if(value.isEmpty){return "Enter Identifiant";}
       else if(!usernameValid ){
          return "Enter valid Identifiant";
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
                    
idValue =idController.text;
              Navigator.pop(context);
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingPagesCopy1(apiService: apiService,idValue:idValue),
      ),
    );

                    
                  }   }
                  ,
child:Text("Get Chauffeurs by ID",style:TextStyle(color:Colors.white)), ),



   ]
    
    ,)),),)
   );

  }

  }
  