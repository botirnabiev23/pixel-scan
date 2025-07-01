import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixel_scan/features/document/domain/document_entity.dart';

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

  void _onAddDocument(_AddDocument event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is Loaded) {
      final newDocument = DocumentEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imagePaths: event.documents,
      );

      final updatedList = List<DocumentEntity>.from(currentState.documents)
        ..add(newDocument);

      emit(
        HomeState.loaded(
          documents: updatedList,
          newestFirst: currentState.newestFirst,
        ),
      );
    }
  }
}
