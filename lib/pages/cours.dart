import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cours_selection.dart';

class CoursPage extends StatefulWidget {
  const CoursPage({
    required this.classeRef,
    Key? key
  }) : super(key: key);

  final String classeRef; // Déclarez la variable classeRef ici

  @override
  _CoursPageState createState() => _CoursPageState(classeRef: classeRef);

}

class _CoursPageState extends State<CoursPage> {
  // Déclarez la variable classeRef dans _CoursPageState
  final String classeRef;

  _CoursPageState({required this.classeRef});

  late List<Map<String, dynamic>> matieres = []; // Liste des matières avec IDs
  late List<Map<String, dynamic>> matieresData = [];

  @override
  void initState() {
    super.initState();
    // Appelle la fonction asynchrone pour récupérer les matières de la classe sélectionnée
    //String selectedClassId = ... // Récupérer l'ID de la classe sélectionnée ici
    fetchMatieresFromFirestore(classeRef);
  }

  // Fonction asynchrone pour récupérer les données des matières depuis Firestore
  Future<void> fetchMatieresFromFirestore(String selectedClassId) async {
    try {
      // Récupère la référence de la collection "classes" dans Firestore
      CollectionReference classesRef =
      FirebaseFirestore.instance.collection('classes');

      // Récupère les documents de la sous-collection "Matieres" de la classe sélectionnée
      QuerySnapshot snapshot = await classesRef
          .doc(selectedClassId) // Utilise l'ID de la classe sélectionnée
          .collection('Matieres')
          .get();

      // Mappe les documents en une liste de noms de matières avec leurs IDs
      List<Map<String, dynamic>> matieresData = snapshot.docs.map((doc) {
        String id = doc.id;
        String intitule = doc['intitule'] as String;
        return {'id': id, 'intitule': intitule};
      }).toList();

      setState(() {
        matieres = matieresData;
      });

    } catch (e) {
      print('Erreur lors de la récupération des matières : $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    // Vérifier si l'utilisateur est connecté
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // L'utilisateur n'est pas connecté, vous pouvez le rediriger vers la page de connexion ici
      return const Center(
        child: Text('Vous n\'êtes pas connecté.'),
      );
    }

    // L'utilisateur est connecté, vous pouvez récupérer son ID
    String userId = user.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cours"),
        backgroundColor: const Color(0xFF233B23),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.blue,
            onPressed: () {
              // Action de recherche
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: const Color(0xFF233B23), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text(
                  'Choisissez une matière',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF233B23),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Utilise un ListView.builder pour afficher les matières dynamiquement
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < matieres.length; i += 2)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // Action liée au premier conteneur
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CoursSelection(
                                                matiere: matieres[i]['id'], classeRef: classeRef, matiereName: matieres[i]['intitule']),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: const Color(0xFF233B23),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        // Image.asset(
                                        //   'assets/images/icone_${matieres[i]
                                        //       .toLowerCase()}.png',
                                        //   height: 70,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        Text(matieres[i]['intitule']),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              if (i + 1 < matieres.length)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Action liée au deuxième conteneur
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CoursSelection(
                                                  matiere: matieres[i + 1]['id'], classeRef: classeRef, matiereName: matieres[i + 1]['intitule'],),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: const Color(0xFF233B23),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          // Image.asset(
                                          //   'assets/images/icone_${matieres[i +
                                          //       1].toLowerCase()}.png',
                                          //   height: 70,
                                          //   fit: BoxFit.cover,
                                          // ),
                                          Text(matieres[i + 1]['intitule']),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}