import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'AccueilPage.dart';
import 'ExercicesPages.dart';
import 'ProfilPage.dart';
import 'cours.dart';

class HomePagee extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePagee> {
  int _currentIndex = 0;

  late Future<String?> nomFuture;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    nomFuture = recupererClasse();
    _pages = [
      const AccueilPage(),
      Container(), // Empty container, will be replaced by CoursPage with classeRef
      const ExercicesPage(),
      const ProfilPage(),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<String?> recupererClasse() async {
    // Récupérer l'utilisateur connecté à partir de FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Si l'utilisateur est connecté, utilisez son ID (UID) pour récupérer les informations depuis Firestore
      DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('utilisateurs').doc(user.uid).get();

      // Vérifiez si les informations de l'utilisateur existent dans Firestore
      if (userSnapshot.exists) {
        // Accédez aux données de l'utilisateur à partir du DocumentSnapshot
        String? classeId = userSnapshot['idclasse'];
        return classeId;
      } else {
        print('Aucune information trouvée pour cet utilisateur dans Firestore.');
        return null;
      }
    } else {
      print('Aucun utilisateur connecté.');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<String?>(
        future: nomFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the Future to complete, show a loading indicator or splash screen.
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            String? classeId = snapshot.data;
            // If the Future is completed and has data, create the CoursPage widget with the retrieved class ID.
            _pages[1] = CoursPage(classeRef: classeId!);
          }

          return IndexedStack(
            index: _currentIndex,
            children: _pages,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:  Color(0xFF233B23),
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color(0xFF121212),
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            // backgroundColor: Color(0xFF233B23),
            label: 'Cours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Exercices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),

    );
  }
}
