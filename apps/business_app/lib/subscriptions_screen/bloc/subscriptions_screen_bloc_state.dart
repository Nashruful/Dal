part of 'subscriptions_screen_bloc_bloc.dart';

@immutable
sealed class SubscriptionsScreenBlocState {}

final class SubscriptionsScreenBlocInitial extends SubscriptionsScreenBlocState {}

final class TabedCardState extends SubscriptionsScreenBlocState {
}