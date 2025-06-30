part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchStart extends SearchEvent {
  final String location;
  SearchStart({required this.location});
}

final class SearchReset extends SearchEvent {}
