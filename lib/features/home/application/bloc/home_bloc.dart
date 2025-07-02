import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixel_scan/features/document/domain/document_entity.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.loading()) {
    on<_LoadDocuments>(_onLoadDocuments);
    on<_ToggleSort>(_onToggleSort);
    on<_AddDocument>(_onAddDocument);
  }

  Future<void> _onLoadDocuments(
    _LoadDocuments event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeState.loaded(documents: [], newestFirst: true));
  }

  void _onToggleSort(_ToggleSort event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is Loaded) {
      emit(
        currentState.copyWith(
          documents: currentState.documents.reversed.toList(),
          newestFirst: !currentState.newestFirst,
        ),
      );
    }
  }

  Future<void> _onAddDocument(
    _AddDocument event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is Loaded) {
      final pdf = pw.Document();

      for (final imagePath in event.documents) {
        final imageFile = File(imagePath);
        final imageBytes = await imageFile.readAsBytes();

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(child: pw.Image(pw.MemoryImage(imageBytes)));
            },
          ),
        );
      }

      final outputDir = await getApplicationDocumentsDirectory();
      final pdfFile = File(
        '${outputDir.path}/${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await pdfFile.writeAsBytes(await pdf.save());

      final newDocument = DocumentEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imagePaths: [pdfFile.path],
      );

      final updatedList = List<DocumentEntity>.from(currentState.documents)
        ..add(newDocument);

      emit(currentState.copyWith(documents: updatedList));
    }
  }
}
