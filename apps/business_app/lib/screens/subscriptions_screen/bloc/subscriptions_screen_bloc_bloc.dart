import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

part 'subscriptions_screen_bloc_event.dart';
part 'subscriptions_screen_bloc_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  int selectedCardIndex = 0;
  String planDesc = 'Basic description'.tr();
  Map<int, bool> selectedPlan = {
    0: true,
    1: false,
    2: false,
  };

  SubscriptionBloc() : super(SubscriptionsScreenBlocInitial()) {
    on<SubscriptionEvent>((event, emit) {});

    on<TabCardEvent>((event, emit) {
      selectedCardIndex = event.index;
      selectedPlan[event.index] = true;

      // Inverse
      for (int i = 0; i < selectedPlan.length; i++) {
        if (i != event.index) {
          selectedPlan[i] = false;
        }
      }
      //change desc
      if (event.index == 0) {
        planDesc = 'Basic description'.tr();
      } else if (event.index == 1) {
        planDesc = 'rfwed';
      } else if (event.index == 2) {
        planDesc = 'uwhif';
      }
      emit(TabedCardState());
    });
  }
}
