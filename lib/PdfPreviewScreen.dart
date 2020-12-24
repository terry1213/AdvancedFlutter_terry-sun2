import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:url_launcher/url_launcher.dart';


class PdfPreviewScreen extends StatelessWidget {
  final String path;

  PdfPreviewScreen({this.path});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("PDF file"),
          actions: <Widget>[ IconButton(
          icon: Icon(Icons.email, color: Colors.white,),
            onPressed: _launchURL,

        )],
      ),
      path: path,
    );
  }

  _launchURL() async {
    const url = 'https://mail.google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}