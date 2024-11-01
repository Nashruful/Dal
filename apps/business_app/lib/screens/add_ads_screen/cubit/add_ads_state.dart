part of 'add_ads_cubit.dart';

@immutable
sealed class AddAdsState {}

final class AddAdsInitial extends AddAdsState {}

final class LoadingState extends AddAdsState {}

final class SuccessState extends AddAdsState {}

final class ErrorState extends AddAdsState {
  final String msg;
  ErrorState({required this.msg});
}

final class CategoryState extends AddAdsState {
  final int categoryValue;
  CategoryState({required this.categoryValue});
}

final class AdsImageState extends AddAdsState {
  final File? image;
  AdsImageState({required this.image});
}

final class SelectDateState extends AddAdsState {
  final DateTime? startDate;
  final DateTime? endDate;
  SelectDateState({this.startDate, this.endDate});
}