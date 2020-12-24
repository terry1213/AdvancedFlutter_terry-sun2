import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'PdfPreviewScreen.dart';
import 'package:image_picker/image_picker.dart';


class PDFPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreatePDFPage(),
    );
  }
}


class CreatePDFPage extends StatefulWidget {
  @override
  _CreatePDFPageState createState() => _CreatePDFPageState();
}

class _CreatePDFPageState extends State<CreatePDFPage> {

  final _updatePriceController = TextEditingController();
  final pdf = pw.Document();
  String defaultimage = "http://handong.edu/site/handong/res/img/logo.png";

  File imageFile;
  bool uploadimage = false;
  var image;

  writeOnPdf(String a){

    // image = PdfImage.file(
    //     pdf.document,
    //     bytes: File(imageFile.path).readAsBytesSync());
    pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(32),

          build: (pw.Context context){
            return <pw.Widget>  [
              pw.Header(
                  level: 0,
                  child: pw.Text(a)
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              //pw.Image.provider(image),

              pw.Header(
                  level: 1,
                  child: pw.Text("Second Heading")
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
            ];
          },


        )
    );
  }

  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("PDF Flutter"),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _updatePriceController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: 'Title',

              ),
            ),
            Text("PDF TUTORIAL", style: TextStyle(fontSize: 34),),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: 380,
                  height: 230.00,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    // Put Your Child widget here.
                  ),
                ),
                uploadimage == false
                    ? Image.network(
                  defaultimage,
                  //width: 230,
                  fit: BoxFit.fill,
                )
                    : Image.file(imageFile)
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 318.0),
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                ),
                onPressed: () {
                  getFromGallery();

                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          writeOnPdf(_updatePriceController.text);
          await savePdf();

          Directory documentDirectory = await getApplicationDocumentsDirectory();

          String documentPath = documentDirectory.path;

          String fullPath = "$documentPath/example.pdf";

          Navigator.push(context, MaterialPageRoute(
              builder: (context) => PdfPreviewScreen(path: fullPath,)
          ));

        },
        child: Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.

    );
  }

  Future getFromGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        uploadimage = true;
      }
    });
  }

  @override
  void dispose() {
    _updatePriceController.dispose();
    // super.dispose();
  }


}