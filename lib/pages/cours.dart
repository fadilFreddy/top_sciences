import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:untitled4/pages/tt.dart';

class CoursPage extends StatelessWidget {
  //final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
   CoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cours'),
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
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Action liée au premier conteneur
                      Navigator.push(context, MaterialPageRoute(builder: (context) => pdfViewer()));
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: const Color(0xFF233B23), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icone_maths.png',
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text("Maths")
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Action liée au deuxième conteneur
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFF233B23), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icone_français.png',
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text("Français")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Action liée au troisième conteneur
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFF233B23), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icone_physique_chimie.png',
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text("physique-chimie")
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Action liée au quatrième conteneur
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFF233B23), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icone_svt.png',
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text("Sciences de la vie et de la Terre")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Action liée au cinquième conteneur
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFF233B23), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icone_histoire.png',
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text("Histoire")
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Action liée au sixième conteneur
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFF233B23), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icone_ses.png',

                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text("Sciences économiques et sociales")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

