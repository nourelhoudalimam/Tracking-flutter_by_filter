/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_api/Controller/apiController.dart';
import 'package:my_api/Model/chauffeur.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/AjoutChauffeur.dart';
import 'package:my_api/View/InputId.dart';

class ListChauffeurparId extends StatefulWidget {
  String idValue;
  final ApiService apiService;

  ListChauffeurparId({required this.idValue, required this.apiService});

  @override
  State<StatefulWidget> createState() => _ListNotePage();
}

class _ListNotePage extends State<ListChauffeurparId> {
  FonctionChauffeur selectedFonction = FonctionChauffeur.CHAUFFEUR;

  TextEditingController filterController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController permisController = TextEditingController();
  TextEditingController teleController = TextEditingController();
  TextEditingController scoreController = TextEditingController();

  late apiController controller;

  Future<void> updateChauffeur(Chauffeur updatedData) async {
    try {
      final String? jwt = await controller.getJwt();
      const apiUrl = 'http://35.180.211.234:1111/api/cubeIT/NaviTrack/rest/chauffeurs/modify-one';
      final Map<String, dynamic> body = {
        'id': updatedData.id,
        'filter': updatedData.filter,
        'fullname': updatedData.fullname,
        'cin': updatedData.cin,
        'tele': updatedData.tele,
        'email': updatedData.email,
        'permis': updatedData.permis,
        'score_avg': updatedData.score_avg,
        'fonction': updatedData.fonction
      };
      if (jwt != null) {
        final response = await http.put(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'},
          body: jsonEncode(body),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Chauffeur updated successfully');
        } else {
          print('Échec de la mise à jour du chauffeur. Erreur: ${response.reasonPhrase},${response.body}');
        }
      } else {
        print('JWT non disponible');
        throw Exception('JWT non disponible');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour du chauffeur: $e');
    }
  }
  
  @override
  void initState() {
    super.initState();
    controller = Get.put(apiController());
    controller.initializeListChauffeurparID(widget.idValue);
  }

  Future<void> _clearData() async {
    widget.idValue = '';
    await controller.clearChauffeurList(); // Add a method in apiController to clear the list
  }

  TextField buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: labelText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("CRUD App", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 87, 9, 3),
      ),
      body: GetBuilder<apiController>(
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.chauffeur.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.chauffeur[index].fullname),
                      subtitle: Text(controller.chauffeur[index].id),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await controller.deleteChauffeur(controller.chauffeur[index].id);
                              await controller.initializeListChauffeur(widget.idValue);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Edit chauffeur"),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        buildTextField("Filter", filterController),
                                        buildTextField("Fullname", fullnameController),
                                        buildTextField("CIN", cinController),
                                        buildTextField("Email", emailController),
                                        buildTextField("Permis", permisController),
                                        buildTextField("Telephone", teleController),
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
                                        ),
                                        buildTextField("Score average", scoreController),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Chauffeur updatedData = Chauffeur(
                                          id: controller.chauffeur[index].id,
                                          filter: filterController.text,
                                          fullname: fullnameController.text,
                                          cin: cinController.text,
                                          email: emailController.text,
                                          permis: permisController.text,
                                          tele: teleController.text,
                                          fonction: FonctionChauffeur.CHAUFFEUR.toString().split('.').last,
                                          score_avg: scoreController.text.isEmpty ? 0 : int.parse(scoreController.text),
                                        );
                                        await updateChauffeur(updatedData);
                                        Navigator.pop(context);
                                        await controller.initializeListChauffeur(widget.idValue);
                                      },
                                      child: Text("Update"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                color: Colors.blue,
                onPressed: () async {
                  // Pop the inputFiltre screen
                  await _clearData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => inputId(),
                    ),
                  );
                },
                child: Text("Return back", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }
}
*/