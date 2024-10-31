part of 'subscriptions_screen_bloc_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

final class TabCardEvent extends SubscriptionEvent {
  final int index;

  TabCardEvent({required this.index});
}
