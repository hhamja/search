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
  }) {
    return AutoCompleteState(
      input: input ?? this.input,
      keywords: keywords ?? this.keywords,
    );
  }
}
