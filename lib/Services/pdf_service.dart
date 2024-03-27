// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_filex/open_filex.dart';
import 'package:http/http.dart' as http;

class PDFService {
  Future<void> createAdAnalysisPDF(
    BuildContext context,
    String brandName,
    String brandURL,
    String adTitle,
    String adCategory,
    String imagePath,
    String adType,
    num remainViews,
    num noOfPlatforms,
    num price,
    String adStatus,
  ) async {
    try {
      final pdf = pw.Document();

      // final image =
      //     await imageFromAssetBundle("assets/images/Sample-Ad-Image-1.jpg");
      // Fetch the image from network
      final http.Response response = await http.get(Uri.parse(imagePath));
      final Uint8List imagebyte = response.bodyBytes;
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(16.0),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Text(
                      'Ad Analysis Report',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Date: ${DateTime.now().toIso8601String()}',
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Center(
                      child: pw.Container(
                        height: 400,
                        width: 400,
                        child: pw.Image(
                          pw.MemoryImage(imagebyte),
                          fit: pw.BoxFit.contain,
                          height: 400,
                          width: 400,
                        ),
                      ),
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Center(
                      child: pw.Text(
                        brandName,
                        style: const pw.TextStyle(
                          fontSize: 24.00,
                        ),
                      ),
                    ),
                    pw.Center(
                      child: pw.Text(
                        brandURL,
                        style: const pw.TextStyle(
                          fontSize: 18.00,
                        ),
                      ),
                    ),
                    pw.Divider(),
                    pw.SizedBox(height: 20),
                    pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Column(
                            children: <pw.Widget>[
                              pw.Text(
                                'Ad Title',
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                'Category',
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                "Remain views",
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                "Types",
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                "Running platforms",
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                "Price plan",
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                "Status",
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                            ],
                          ),
                          pw.Column(
                            children: <pw.Widget>[
                              pw.Text(
                                adTitle,
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                adCategory,
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                remainViews.toString(),
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                adType,
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                noOfPlatforms.toString(),
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                "$price",
                                style: const pw.TextStyle(
                                  fontSize: 16.00,
                                ),
                              ),
                              pw.Text(
                                adStatus,
                                style: adStatus == "ongoing"
                                    ? pw.TextStyle(
                                        fontSize: 16.00,
                                        color: PdfColor.fromHex("#00FF00"),
                                      )
                                    : adStatus == "pending"
                                        ? pw.TextStyle(
                                            fontSize: 16.00,
                                            color: PdfColor.fromHex("#FF0000"),
                                          )
                                        : pw.TextStyle(
                                            fontSize: 16.00,
                                            color: PdfColor.fromHex("#0000FF"),
                                          ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 20.00),
                    pw.Text(
                      "For further information open \"AdBrokers\" application and view this Ads analysis",
                      style: const pw.TextStyle(
                        fontSize: 16.00,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
      // Get the device's documents directory
      final docDirectory = await getExternalStorageDirectory();

      String docPath = docDirectory!.path.toString();
      // Create the PDF file
      final File pdfFile = File("$docPath/$adTitle.pdf");
      await pdfFile.writeAsBytes(await pdf.save());
      // Open the PDF file
      OpenFilex.open("$docPath/$adTitle.pdf");
    } catch (ex) {
      debugPrint(ex.toString());
      UiHelper.customErrorSnackBar(context, ex.toString());
    }
  }
}
