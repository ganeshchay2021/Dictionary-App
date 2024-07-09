import 'package:dictionaryapp/Pages/Widgets/my_text_style.dart';
import 'package:dictionaryapp/bloc/dictionary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextFieldWidgets extends StatelessWidget {
  final String searchHintText;
  final IconData searchIcon;
  const SearchTextFieldWidgets({
    super.key,
    required this.searchHintText,
    required this.searchIcon,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    TextEditingController search = TextEditingController();
    return Container(
      height: height * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          context.read<DictionaryBloc>().add(
                DictionarySearchEvent(searchText: search.text),
              );
        },
        controller: search,
        style: myTextStyle(fontsize: width * 0.04, color: Colors.black),
        decoration: InputDecoration(
            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? Colors.teal
                    : Colors.grey),
            suffixIcon: Icon(
              searchIcon,
              size: width * 0.07,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.teal, width: 2)),
            hintText: searchHintText,
            hintStyle: myTextStyle(fontsize: width * 0.036, color: Colors.grey)),
      ),
    );
  }
}
