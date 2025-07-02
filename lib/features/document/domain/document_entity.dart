class DocumentEntity {
  final String id;
  final List<String> imagePaths;
  final String? pdfPath;

  DocumentEntity({required this.id, required this.imagePaths, this.pdfPath});
}
