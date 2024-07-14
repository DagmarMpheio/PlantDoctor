import 'dart:io';
//import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class Pdfreport {
  final pdf = pw.Document();

  var description;

  var diseasename;

  var remedy;

  var image;
 Future<int> generatepdf(diseasename, description, remedy, image) async {
  final image1 = pw.MemoryImage(
    File(image).readAsBytesSync(),
  );

  // Crie um novo documento PDF
  final pdf = pw.Document();

  // Adicione a primeira página ao documento
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text(
            'Disease Report',
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
          ),
          pw.Center(child: pw.Image(image1)),
          pw.Text(
            'Disease:',
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
          ),
          pw.Text(
            diseasename,
            textAlign: pw.TextAlign.justify,
            style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15),
          ),
          pw.Text(
            'Description:',
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
          ),
          pw.Text(
            description,
            textAlign: pw.TextAlign.justify,
            style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15),
          ),
          pw.Text(
            'Remedy:',
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
          ),
          pw.Text(
            remedy,
            textAlign: pw.TextAlign.justify,
            style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 15),
          ),
        ],
      ),
    ),
  );

  // Obtenha o diretório de armazenamento externo
  Directory? externalDirectory = await getExternalStorageDirectory();
  final file = File(externalDirectory!.path + "/report.pdf");

  // Salve o documento PDF
  await file.writeAsBytes(await pdf.save());

  // Retorne um valor indicando que o PDF foi gerado com sucesso
  return 1;
}

}
