import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
import 'package:untitled4/pages/cours_affichage.dart';

class CoursSelection extends StatefulWidget {


  const CoursSelection({
    required this.matiere,
    required this.classeRef,
    Key? key,
    required this.matiereName,
  }) : super(key: key);

  final String matiere;
  final String classeRef;
  final String matiereName;

  @override
  State<CoursSelection> createState() => _CoursSelectionState();
}

class _CoursSelectionState extends State<CoursSelection> {
  late List<Map<String, dynamic>> coursList = [];

  @override
  void initState() {
    super.initState();
    fetchCoursFromFirestore();
  }

  Future<void> fetchCoursFromFirestore() async {
    try {
      CollectionReference coursRef = FirebaseFirestore.instance
          .collection('classes')
          .doc(widget.classeRef)
          .collection('Matieres')
          .doc(widget.matiere)
          .collection('Cours');

      QuerySnapshot coursSnapshot = await coursRef.get();

      coursList = coursSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      setState(() {
        // Actualise l'interface avec la liste des cours
      });
    } catch (e) {
      print('Erreur lors de la récupération des cours : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matiereName),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: const Color(0xFF233B23), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
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
            Expanded( // Wrap the SingleChildScrollView with an Expanded widget
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var coursData in coursList)
                      Card(
                        elevation: 2,
                        child: ListTile(
                          leading: const Icon(Icons.announcement, color: Color(0xFF233B23)),
                          title: Text(coursData['titre'] ?? ''),
                          subtitle: Text(coursData['description'] ?? ''),
                          onTap: () {
                            // Action liée à un cours
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AfficheCours()),
                            );
                          },
                        ),
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

class CoursViewer extends StatelessWidget {
  final Map<String, dynamic> coursData;

  CoursViewer({required this.coursData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coursData['titre'] ?? ''),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(coursData['titre'] ?? ''),
              Text(coursData['contenu'] ?? ''),
              // ... Autres informations de cours à afficher
            ],
          ),
        ),
      ),
    );
  }
}