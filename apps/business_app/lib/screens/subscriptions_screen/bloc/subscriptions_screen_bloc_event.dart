part of 'subscriptions_screen_bloc_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

final class TabCardEvent extends SubscriptionEvent {
  final int index;

  TabCardEvent({required this.index});
}

final class confirmSubscription extends SubscriptionEvent {
  final DateTime start;
  final DateTime end;
  final bool isFreeTrial;

  confirmSubscription({required this.isFreeTrial,required this.start, required this.end});
}
