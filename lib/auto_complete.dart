import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/auto_complete_cubit.dart';

/// 자동 완성 검색 위젯
class AutoComplete extends StatefulWidget {
  const AutoComplete({super.key});

  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusMode = FocusNode();

  List<TextSpan> _getHighlightedTextSpans({
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

  @override
  void dispose() {
    searchController.dispose();
    AutoCompleteCubit().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final autoCompleteCubit = context.read<AutoCompleteCubit>();

    return Column(
      children: [
        TextField(
          controller: searchController,
          focusNode: focusMode,
          onTapOutside: (_) {
            focusMode.unfocus();
          },
          onChanged: (query) {
            autoCompleteCubit.fetchAutoCompleteKeywords(query);
          },
          decoration: const InputDecoration(hintText: '검색하기'),
        ),
        Container(
          color: Colors.white,
          constraints: const BoxConstraints(maxHeight: 400),
          child: BlocBuilder<AutoCompleteCubit, List<String>>(
            builder: (context, state) {
              final List<String> autoCompleteKeywords = state;
              return searchController.text == ''
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: autoCompleteKeywords.length,
                      itemBuilder: (context, index) {
                        final keyword = autoCompleteKeywords[index];
                        final inputLower = searchController.text.toLowerCase();
                        final keywordLower = keyword.toLowerCase();
                        final highlightedText = RichText(
                          text: TextSpan(
                            children: _getHighlightedTextSpans(
                                input: inputLower, keyword: keywordLower),
                            style: DefaultTextStyle.of(context).style,
                          ),
                        );
                        return ListTile(
                          title: highlightedText,
                          onTap: () {
                            searchController.text = keyword;
                            autoCompleteCubit
                                .fetchAutoCompleteKeywords(keyword);
                          },
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
