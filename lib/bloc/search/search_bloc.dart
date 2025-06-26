import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchStart>((event, emit) async {
      await search(event, emit);
    });

    on<SearchReset>((event, emit) {
      emit(SearchInitial());
    });
  }
}


Future<void> search(SearchStart event , Emitter<SearchState> emit) async{
  emit(SearchLoading());
  try{
    var url = Uri.parse(
      "https://geocoding-api.open-meteo.com/v1/search?name=${event.location}&count=100",
    );
    final res = await http.get(url);
    final locs = jsonDecode(res.body);

    if(locs["results"] == null){
      return emit(SearchFailure(error: "Location not found"));
    }

    return  emit(SearchSuccess(locations: locs["results"]));
  } catch (e) {
    return emit(SearchFailure(error: "$e"));
  }
}