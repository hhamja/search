import 'package:flutter/material.dart';

class AutoCompleteState {
  final String input;
  final List<String> keywords;

  AutoCompleteState({
    required this.keywords,
    required this.input,
  });

  factory AutoCompleteState.initial() {
    return AutoCompleteState(input: '', keywords: []);
  }

  AutoCompleteState copyWith({
    String? input,
    List<String>? keywords,
    List<TextSpan>? highlightText,
  }) {
    return AutoCompleteState(
      input: input ?? this.input,
      keywords: keywords ?? this.keywords,
    );
  }
}
