part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadDocuments() = _LoadDocuments;
  const factory HomeEvent.toggleSort() = _ToggleSort;
  const factory HomeEvent.addDocument(List<String> documents) = _AddDocument;
}
