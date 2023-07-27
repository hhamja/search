import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/auto_complete_state.dart';
import 'package:search/data/client/auto_complete_client.dart';
import 'package:search/data/repository/auto_complete_repository.dart';

class AutoCompleteCubit extends Cubit<AutoCompleteState> {
  AutoCompleteCubit() : super(AutoCompleteState.initial());

  void fetchAutoCompleteKeywords(String query) async {
    if (query.isEmpty) {
      emit(AutoCompleteState.initial());
    }
    final autoCompleteClient = AutoCompleteClient();
    final repository = AutoCompleteRepository(autoCompleteClient);
    final keywords = await repository.fetchAutoCompleteKeywords(query);

    emit(state.copyWith(input: query, keywords: keywords));
  }

  List<TextSpan> getHighlightedTextSpans({
    required String keyword,
    required String input,
  }) {
    List<TextSpan> spans = [];
    int startIndex = 0;
    keyword = keyword.toLowerCase();
    input = input.toLowerCase();

    while (startIndex < keyword.length) {
      final int index = keyword.indexOf(input, startIndex);
      if (index == -1) {
        spans.add(TextSpan(text: keyword.substring(startIndex)));
        break;
      }
      if (index > startIndex) {
        spans.add(TextSpan(text: keyword.substring(startIndex, index)));
      }
      final matchedText = keyword.substring(index, index + input.length);
      spans.add(
        TextSpan(
          text: matchedText,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      startIndex = index + input.length;
    }
    return spans;
  }
}
