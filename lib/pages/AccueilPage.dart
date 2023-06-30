import 'package:flutter/material.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: const Color(0xFF233B23),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dernières annonces',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF233B23),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.announcement, color: Color(0xFF233B23)),
                title: const Text("Annonce 1"),
                subtitle: const Text("Description de l'annonce 1"),
                onTap: () {
                  // Action liée à l'annonce 1
                },
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.announcement, color: Color(0xFF233B23)),
                title: const Text('Annonce 2'),
                subtitle: const Text('Description de l\'annonce 2'),
                onTap: () {
                  // Action liée à l'annonce 2
                },
              ),
            ),
            // Autres éléments de contenu...
          ],
        ),
      ),
    );
  }
}
