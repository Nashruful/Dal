import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'subscriptions_screen_bloc_event.dart';
part 'subscriptions_screen_bloc_state.dart';

class SubscriptionsScreenBlocBloc
    extends Bloc<SubscriptionsScreenBlocEvent, SubscriptionsScreenBlocState> {
  int selectedCardIndex = 0;
  SubscriptionsScreenBlocBloc() : super(SubscriptionsScreenBlocInitial()) {
    on<SubscriptionsScreenBlocEvent>((event, emit) {});

    on<TabCardEvent>((event, emit) {
      selectedCardIndex = event.index;
      emit(TabedCardState());
    });
  }
}
