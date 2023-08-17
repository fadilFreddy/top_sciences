import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';



class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text("View PDF with Caching"), //appbar title
            backgroundColor: Colors.redAccent //appbar background color
        ),
        body: Container(
            child: PDF().cachedFromUrl(
              'https://firebasestorage.googleapis.com/v0/b/top-science-8fd65.appspot.com/o/cours%2FTOP-SCIENCE.pdf?alt=media&token=1f589eea-258f-49fb-a1de-b1aeb7c9815a',
              maxAgeCacheObject:Duration(days: 30), //duration of cache
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            )
        )
    );
  }
}