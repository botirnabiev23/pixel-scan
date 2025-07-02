import 'package:flutter/material.dart';
import 'package:pixel_scan/features/document/domain/document_entity.dart';

class DocumentList extends StatelessWidget {
  final List<DocumentEntity> documents;
  final void Function(DocumentEntity document) onDocumentTap;

  const DocumentList({
    super.key,
    required this.documents,
    required this.onDocumentTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final doc = documents[index];
        return GestureDetector(
          onTap: () => onDocumentTap(doc),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Документ ${doc.id}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
