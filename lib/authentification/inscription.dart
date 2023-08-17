import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  List<String> classes = []; // Liste pour stocker les noms des classes depuis Firebase
  String? selectedClass; // La classe sélectionnée par l'utilisateur
  List<String> classIds = []; // Liste pour stocker les IDs des classes depuis Firebase


  @override
  void initState() {
    super.initState();
    // Appelle une fonction asynchrone pour récupérer les données de la collection "classes"
    fetchClassesFromFirestore();
  }

  // Fonction asynchrone pour récupérer les données de la collection "classes" depuis Firestore
  Future<void> fetchClassesFromFirestore() async {
    try {
      // Récupère la référence de la collection "classes" dans Firestore
      CollectionReference classesRef =
      FirebaseFirestore.instance.collection('classes');

      // Récupère les documents de la collection "classes"
      QuerySnapshot snapshot = await classesRef.get();

      // Mappe les documents en une liste de noms de classes et d'IDs
      List<String> classNames =
      snapshot.docs.map((doc) => doc['intitule'] as String).toList();
      List<String> ids =
      snapshot.docs.map((doc) => doc.id).toList(); // Récupère les IDs

      setState(() {
        classes = classNames;
        classIds = ids;
      });

      // Ici, la liste devrait être remplie correctement
      print(classes);
    } catch (e) {
      print('Erreur lors de la récupération des classes : $e');
    }
  }

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController nomController = TextEditingController();
  late TextEditingController prenomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 30),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    labelText: 'Nom',
                    prefixIcon: Icon(Icons.person_2_rounded),
                    hintText: 'Entrez votre nom',
                  ),
                  autofocus: false,
                  controller: nomController,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 30),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    labelText: 'Prénom',
                    prefixIcon: Icon(Icons.person_rounded),
                    hintText: 'Entrez votre prénom',
                  ),
                  autofocus: false,
                  controller: prenomController,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 30),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    labelText: 'Adresse mail',
                    prefixIcon: Icon(Icons.mail_outline_outlined),
                    hintText: 'Entrez votre mail',
                  ),
                  autofocus: false,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 30),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    labelText: 'Mot de passe',
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Entrez votre mot de passe',
                  ),
                  autofocus: false,
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 300,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 30),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    labelText: 'Mot de passe',
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Confirmez votre mot de passe',
                  ),
                  autofocus: false,
                ),
              ),
              const SizedBox(height: 10),
              if (classes.isNotEmpty) // Vérifie que la liste classes n'est pas vide
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: classes
                        .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: selectedClass,
                    onChanged: (String? value) {
                      setState(() {
                        selectedClass = value!;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.redAccent,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.yellow,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.redAccent,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () async {
                  try {
                    await _auth.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    // Récupérer l'identifiant de l'utilisateur connecté
                    User? user = _auth.currentUser;
                    String? uid = user?.uid;

                    // Récupérer l'identifiant de la classe sélectionnée
                    String? selectedClassId =
                    classIds[classes.indexOf(selectedClass!)];


                    // Ajouter le nom, le prénom, l'ID de la classe sélectionnée et la classe à la collection "utilisateurs"
                    await _firestore.collection('utilisateurs').doc(uid).set({
                      'nom': nomController.text,
                      'prenom': prenomController.text,
                      'classe': selectedClass, // Ajoute la classe sélectionnée
                      'idclasse': selectedClassId, // Ajoute l'ID de la classe sélectionnée


                    });

                    // L'enregistrement s'est effectué avec succès
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Inscription réussie'),
                          content: const Text('Vous pouvez maintenant vous connecter.'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    print(e.toString());
                    // Gérer les erreurs d'enregistrement
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erreur d\'inscription'),
                          content: const Text('Une erreur s\'est produite lors de l\'inscription. Veuillez réessayer.'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
