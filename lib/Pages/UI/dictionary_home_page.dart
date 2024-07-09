import 'package:dictionaryapp/Pages/Widgets/dictionary_home_page_body.dart';
import 'package:dictionaryapp/bloc/dictionary_bloc.dart';
import 'package:dictionaryapp/repository/dictionary_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryHomePage extends StatelessWidget {
  const DictionaryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DictionaryBloc(dictionaryRepository: DictionaryRepository()),
      child: const DictionaryHomePageBody(),
    );
  }
}
