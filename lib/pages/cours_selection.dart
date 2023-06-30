import 'package:flutter/material.dart';
class CoursSelection extends StatelessWidget {
  const CoursSelection({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> pdfList = [
      'PDF 1',
      'PDF 2',
      'PDF 3',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours'),
        backgroundColor: Color(0xFF233B23),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.blue,
            onPressed: () {
              // Action de recherche
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Color(0xFF233B23), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: const Center(
          child: Text(

            'Choisis ton cours!',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF233B23),
            ),
          ),

        ),
      ),


    );
  }
}
