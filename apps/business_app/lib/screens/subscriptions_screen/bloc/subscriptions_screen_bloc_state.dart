part of 'subscriptions_screen_bloc_bloc.dart';

@immutable
sealed class SubscriptionState {}

final class SubscriptionsScreenBlocInitial extends SubscriptionState {}

final class TabbedCardState extends SubscriptionState {}

final class LoadingSubscriptionState extends SubscriptionState {}

final class SubscriptionConfirmedState extends SubscriptionState {}

final class ConfirmedState extends SubscriptionState {}

final class ErrorState extends SubscriptionState {
  final String msg;
  ErrorState({required this.msg});
}

final class SubscriptionErrorState extends SubscriptionState {
  final String msg;
  SubscriptionErrorState({required this.msg});
}
