import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/auto_complete_cubit.dart';
import 'package:search/bloc/auto_complete_state.dart';

/// 자동 완성 검색 위젯
class AutoComplete extends StatefulWidget {
  const AutoComplete({super.key});

  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusMode = FocusNode();

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
          child: BlocBuilder<AutoCompleteCubit, AutoCompleteState>(
            builder: (context, state) {
              final List<String> autoCompleteKeywords = state.keywords;
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
                            children: autoCompleteCubit.getHighlightedTextSpans(
                              input: inputLower,
                              keyword: keywordLower,
                            ),
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
