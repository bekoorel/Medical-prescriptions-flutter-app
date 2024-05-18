import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'filter_network_list_page.dart';

class printroshet extends StatefulWidget {
  const printroshet(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<printroshet> createState() => _printroshetState();
}

class _printroshetState extends State<printroshet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (format) => _generatePdf(format, widget.title),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    Uint8List fontData =
        File('assets/fonts/Cairo-Regular.ttf').readAsBytesSync();
    var data = fontData.buffer.asByteData();

    var myFont = pw.Font.ttf(data);
    var myStyle = pw.TextStyle(
        font: myFont, fontWeight: pw.FontWeight.bold, fontSize: 11);
    var myStylee = pw.TextStyle(
        font: myFont, fontWeight: pw.FontWeight.bold, fontSize: 20);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Container(
                  margin: pw.EdgeInsets.fromLTRB(0, 170, 0, 0),
                  width: 500.0,
                  child: pw.ListView.builder(
                    itemCount: printlis.length,
                    itemBuilder: ((context, index) {
                      return pw.Container(
                          // decoration: pw.BoxDecoration(border: pw.Border.all()),
                          margin: pw.EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.Column(
                                children: [
                                  pw.Text('${printlis[index]['name']}',
                                      style: myStylee,
                                      textDirection: pw.TextDirection.rtl),
                                  pw.SizedBox(width: 60.0),
                                  pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceEvenly,
                                      children: [
                                        pw.Text(
                                            '${printlis[index]['discripshn']}',
                                            style: myStyle,
                                            textDirection:
                                                pw.TextDirection.rtl),
                                        pw.SizedBox(width: 10.0),
                                        pw.Text('${printlis[index]['instrac']}',
                                            style: myStyle,
                                            textDirection:
                                                pw.TextDirection.rtl),
                                        pw.SizedBox(width: 10.0),
                                        pw.Text('${printlis[index]['count']}',
                                            style: myStyle,
                                            textDirection:
                                                pw.TextDirection.rtl),
                                      ]),
                                ],
                              ),
                            ],
                          ));
                    }),
                  ))
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
