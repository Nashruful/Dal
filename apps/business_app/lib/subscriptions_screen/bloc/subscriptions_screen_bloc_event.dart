part of 'subscriptions_screen_bloc_bloc.dart';

@immutable
sealed class SubscriptionsScreenBlocEvent {}

final class TabCardEvent extends SubscriptionsScreenBlocEvent {
  final int index;

  TabCardEvent({required this.index});
}
