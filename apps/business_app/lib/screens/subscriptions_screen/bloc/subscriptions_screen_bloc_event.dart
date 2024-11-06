part of 'subscriptions_screen_bloc_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

final class TabCardEvent extends SubscriptionEvent {
  final int index;

  TabCardEvent({required this.index});
}

final class ConfirmSubscription extends SubscriptionEvent {
  final DateTime start;
  final DateTime end;
  final bool isFreeTrial;
  final double price;
  final String planType;
  final List selectedBranch;

  ConfirmSubscription({required this.isFreeTrial,required this.start, required this.end, required this.price, required this.planType, required this.selectedBranch});
}
