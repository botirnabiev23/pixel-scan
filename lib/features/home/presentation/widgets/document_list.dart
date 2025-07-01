import 'package:flutter/material.dart';
import 'package:pixel_scan/features/document/domain/document_entity.dart';

class DocumentList extends StatelessWidget {
  final List<DocumentEntity> documents;

  const DocumentList({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final doc = documents[index];
        return Container(
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
            'Document ${doc.id}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }
}
