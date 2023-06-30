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

  final List<Widget> _pages = [
    const AccueilPage(),
    CoursPage(),
    const ExercicesPage(),
    const ProfilPage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Ma page'),
      // ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
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
