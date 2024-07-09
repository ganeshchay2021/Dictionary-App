part of 'dictionary_bloc.dart';

sealed class DictionaryEvent extends Equatable {
  const DictionaryEvent();

  @override
  List<Object> get props => [];
}

class DictionarySearchEvent extends DictionaryEvent {
  final String searchText;

  const DictionarySearchEvent({required this.searchText});
}
