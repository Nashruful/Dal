part of 'my_ads_cubit.dart';

@immutable
sealed class MyAdsState {}

final class MyAdsInitial extends MyAdsState {}

final class LoadingAdsState extends MyAdsState {}

final class AdErrorState extends MyAdsState {}

final class SuccessDeleteState extends MyAdsState {}

final class SuccessRefreshState extends MyAdsState {}
