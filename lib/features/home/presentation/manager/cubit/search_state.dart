part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchSuccess extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchFailed extends SearchState {}

final class SearchEmpty extends SearchState {}
