import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PDFGenerator {
  static Future<File> createPdfFromImages(
    List<String> imagePaths,
    String documentId,
  ) async {
    final pdf = pw.Document();

    for (final path in imagePaths) {
      final image = File(path).readAsBytesSync();
      final pdfImage = pw.MemoryImage(image);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Center(child: pw.Image(pdfImage, fit: pw.BoxFit.contain));
          },
        ),
      );
    }

    final outputDir = await getApplicationDocumentsDirectory();
    final outputFile = File('${outputDir.path}/document_$documentId.pdf');

    await outputFile.writeAsBytes(await pdf.save());
    return outputFile;
  }
}
