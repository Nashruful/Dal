part of 'subscriptions_screen_bloc_bloc.dart';

@immutable
sealed class SubscriptionState {}

final class SubscriptionsScreenBlocInitial extends SubscriptionState {}

final class TabedCardState extends SubscriptionState {
}

final class LoadingState extends SubscriptionState {
}

final class SubscriptionConfirmedState extends SubscriptionState {
}

final class ErrorState extends SubscriptionState {
}

final class SubscriptionErrorState extends SubscriptionState {
}

