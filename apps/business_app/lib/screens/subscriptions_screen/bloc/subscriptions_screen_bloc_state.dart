part of 'subscriptions_screen_bloc_bloc.dart';

@immutable
sealed class SubscriptionState {}

final class SubscriptionsScreenBlocInitial extends SubscriptionState {}

final class TabedCardState extends SubscriptionState {
}