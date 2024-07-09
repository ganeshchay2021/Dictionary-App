part of 'dictionary_bloc.dart';

sealed class DictionaryState extends Equatable {
  const DictionaryState();

  @override
  List<Object> get props => [];
}

final class DictionaryInitialState extends DictionaryState {}

final class DictionaryLoadingState extends DictionaryState {}

final class DictionarySuccessState extends DictionaryState {
  final DictionaryModel dictionaryModel;

  const DictionarySuccessState({required this.dictionaryModel});

  @override
  List<Object> get props => [dictionaryModel];
}

final class DictionaryErrorState extends DictionaryState {
  final String errorMsg;

  const DictionaryErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
