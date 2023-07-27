import 'package:search/data/resource/majors.dart';

class AutoCompleteClient {
  Future<List<String>> fetchAutoCompleteKeywords(String typedKeyword) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (typedKeyword.isEmpty) return [];
    return List.from(
      Major.keywords.where(
        (element) => element.contains(typedKeyword),
      ),
    );
  }
}
