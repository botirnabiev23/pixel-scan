part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = Loading;
  const factory HomeState.loaded({
    required List<DocumentEntity> documents,
    required bool newestFirst,
  }) = Loaded;
  const factory HomeState.error(String message) = Error;
}
