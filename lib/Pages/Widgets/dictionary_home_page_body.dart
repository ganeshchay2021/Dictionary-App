import 'package:audioplayers/audioplayers.dart';
import 'package:dictionaryapp/Pages/Widgets/my_text_style.dart';
import 'package:dictionaryapp/Pages/Widgets/search_textfield.dart';
import 'package:dictionaryapp/bloc/dictionary_bloc.dart';
import 'package:dictionaryapp/model/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryHomePageBody extends StatefulWidget {
  const DictionaryHomePageBody({super.key});

  @override
  State<DictionaryHomePageBody> createState() => _DictionaryHomePageBodyState();
}

class _DictionaryHomePageBodyState extends State<DictionaryHomePageBody> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dictionary"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SearchTextFieldWidgets(
              searchHintText: "Search",
              searchIcon: Icons.search,
            ),
            BlocBuilder<DictionaryBloc, DictionaryState>(
              builder: (context, state) {
                if (state is DictionaryLoadingState) {
                  return LinearProgressIndicator(
                    color: Colors.teal.shade300,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(
              height: height * 0.006,
            ),
            Expanded(
              child: BlocBuilder<DictionaryBloc, DictionaryState>(
                builder: (context, state) {
                  if (state is DictionarySuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.024,
                        ),
                        Text(
                          state.dictionaryModel.word,
                          style: myTextStyle(
                              color: Colors.blue,
                              fontsize: height * 0.0311,
                              fontweight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              state.dictionaryModel.phonetics.isNotEmpty
                                  ? state.dictionaryModel.phonetics[0].text ??
                                      ""
                                  : "",
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                if (state.dictionaryModel.phonetics.isEmpty ||
                                    state.dictionaryModel.phonetics[0].audio
                                        .isEmpty) {
                                  return;
                                }

                                final audioUrl =
                                    state.dictionaryModel.phonetics[0].audio;

                                final player = AudioPlayer();

                                await player.play(UrlSource(audioUrl));
                              },
                              icon: const Icon(
                                Icons.volume_up_rounded,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.dictionaryModel.meanings.length,
                            itemBuilder: (context, index) {
                              return showMeaning(
                                  state.dictionaryModel.meanings[index]);
                            },
                          ),
                        )
                      ],
                    );
                  } else if (state is DictionaryErrorState) {
                    return Text(state.errorMsg);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  showMeaning(Meaning meaning) {
    String wordDefination = "";
    for (var element in meaning.definitions) {
      int index = meaning.definitions.indexOf(element);
      wordDefination += "${index + 1}.${element.definition}\n\n";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meaning.partOfSpeech,
                style: myTextStyle(
                    fontsize: 22,
                    color: Colors.blue,
                    fontweight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Definition : ",
                style: myTextStyle(
                    fontweight: FontWeight.bold,
                    fontsize: 18,
                    color: Colors.black),
              ),
              Text(
                wordDefination,
                style: myTextStyle(fontsize: 16, height: 1),
              ),
              wordRelation("Synonyms", meaning.synonyms),
              wordRelation("Synonyms", meaning.antonyms),
            ],
          ),
        ),
      ),
    );
  }

  wordRelation(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: myTextStyle(fontweight: FontWeight.bold, fontsize: 18),
          ),
          Text(
            setList!.toSet().toString().replaceAll("{", "").replaceAll("}", ""),
            style: myTextStyle(fontsize: 18),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
