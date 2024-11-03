part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class LoadingState extends SearchState {}
final class SuccessState extends SearchState {}


final class ErrorState extends SearchState {
  final String msg;
  ErrorState({required this.msg});
}

final class SearchAdsState extends SearchState {
  final List<Ads> ads;
  SearchAdsState({required this.ads});
}