// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dictionaryapp/model/dictionary_model.dart';
import 'package:equatable/equatable.dart';

import 'package:dictionaryapp/repository/dictionary_repository.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final DictionaryRepository dictionaryRepository;
  DictionaryBloc({required this.dictionaryRepository})
      : super(DictionaryInitialState()) {
    on<DictionarySearchEvent>(
      (event, emit) async {
        emit(DictionaryLoadingState());
        final result =
            await dictionaryRepository.fetchData(word: event.searchText);
        result.fold(
          (data) => emit(DictionarySuccessState(dictionaryModel: data)),
          (error) => emit(
            DictionaryErrorState(errorMsg: error),
          ),
        );
      },
    );
  }
}
