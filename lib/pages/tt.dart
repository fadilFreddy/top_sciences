import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class pdfViewer extends StatefulWidget {
  const pdfViewer({super.key});

  @override
  State<pdfViewer> createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {

  late PdfController pdfController;

  @override
  void initState(){
    super.initState();
    loadController();
  }
  
  loadController(){
    pdfController = PdfController(document: PdfDocument.openAsset('assets/docs/TOP-SCIENCE.pdf'));
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
      body: Center(
        child: Column(
          children: [
            PdfView(controller: pdfController)
          ],
        ),
      ),
    );
  }
}
