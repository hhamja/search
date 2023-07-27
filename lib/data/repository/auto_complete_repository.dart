import 'package:search/data/client/auto_complete_client.dart';

class AutoCompleteRepository {
  final AutoCompleteClient _autoCompleteClient;
  AutoCompleteRepository(this._autoCompleteClient);

  Future<List<String>> fetchAutoCompleteKeywords(String typedKeyword) async {
    try {
      return _autoCompleteClient.fetchAutoCompleteKeywords(typedKeyword);
    } catch (e) {
      throw Exception('리스트를 불러오지 못했습니다.');
    }
  }
}
