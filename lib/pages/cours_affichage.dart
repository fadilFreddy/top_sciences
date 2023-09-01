import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class AfficheCours extends StatefulWidget {
  const AfficheCours({Key? key});

  @override
  State<AfficheCours> createState() => _AfficheCoursState();
}

class _AfficheCoursState extends State<AfficheCours> {
  PdfController? pdfController;


  @override
  void initState() {
    super.initState();
    loadController();
  }


  loadController() async {
    try {
      final pdfBytes = await downloadPDF();
      if (pdfBytes != null) {
        setState(() {
          pdfController = PdfController(document: PdfDocument.openData(pdfBytes));
        });
      } else {
        // Gérer le cas où le téléchargement a échoué
        print("Échec du téléchargement du PDF");
      }
    } catch (e) {
      // Gérer les erreurs lors du téléchargement ou de l'ouverture du PDF
      print("Erreur lors du chargement du PDF : $e");
    }
  }

  Future<Uint8List?> downloadPDF() async {
    final response = await http.get(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/top-science-8fd65.appspot.com/o/cours%2FTOP-SCIENCE.pdf?alt=media&token=1f589eea-258f-49fb-a1de-b1aeb7c9815a'));

    if (response.statusCode == 200)

    {
      print("telechargement effectué");

      return response.bodyBytes;
    }

    else {
      return null;
    }
  }

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            if (pdfController != null)
              SizedBox(
                height: 500,
                child: PdfView(
                  controller: pdfController!,
                ),
              )
            else
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
