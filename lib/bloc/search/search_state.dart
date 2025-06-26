part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<dynamic> locations;

  SearchSuccess({required this.locations});
}

final class SearchFailure extends SearchState {
  final String error;
  SearchFailure({required this.error});
}
