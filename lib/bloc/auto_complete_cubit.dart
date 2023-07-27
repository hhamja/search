import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/data/client/auto_complete_client.dart';
import 'package:search/data/repository/auto_complete_repository.dart';

class AutoCompleteCubit extends Cubit<List<String>> {
  AutoCompleteCubit() : super([]);

  void fetchAutoCompleteKeywords(String query) async {
    if (query.isEmpty) {
      emit([]);
    }
    final autoCompleteClient = AutoCompleteClient();
    final repository = AutoCompleteRepository(autoCompleteClient);
    final keywords = await repository.fetchAutoCompleteKeywords(query);

    emit(keywords);
  }
}
