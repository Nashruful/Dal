import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

part 'subscriptions_screen_bloc_event.dart';
part 'subscriptions_screen_bloc_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  int selectedCardIndex = 0;
  String planDesc = 'Basic description'.tr();
  MultiSelectController<int>? basicPlanController = MultiSelectController();
  MultiSelectController<int>? standardPlanController = MultiSelectController();
  MultiSelectController<int>? enterpriseController = MultiSelectController();
  final branches = getIt.get<DataLayer>().businessBranches;
  Map plan = getIt.get<DataLayer>().latestSubscription;
  List selectedBranch = [];
  Map<int, bool> selectedPlan = {
    0: true,
    1: false,
    2: false,
  };
  String planType = 'Basic';
  double planPrice = 100;
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
        planType = 'Basic';
        planPrice = 100;
      } else if (event.index == 1) {
        planDesc = 'Premium description'.tr();
        planType = 'Premium';
        planPrice = 250;
      } else if (event.index == 2) {
        planDesc = 'Premium description'.tr();
        planType = 'Enterprise';
        planPrice = 500;
      }
      emit(TabedCardState());
    });

    on<confirmSubscription>((event, emit) async {
      emit(loadingState());
      try {
        await getIt
            .get<DataLayer>()
            .supabase
            .from("subscription_business")
            .insert({
              "business_id": getIt.get<DataLayer>().businessId!,
              "subscription_type": planType,
              "start_date": event.start.toIso8601String(),
              "end_date": event.end.toIso8601String(),
            })
            .select()
            .single();

        if (selectedBranch.isNotEmpty) {
          // get branch ids for selected branches
          final branchIds = getIt
              .get<DataLayer>()
              .businessBranches
              .where((branch) => selectedBranch.contains(branch['address']))
              .map((branch) => branch['id'])
              .toList();

          for (var branchId in branchIds) {
            await getIt
                .get<DataLayer>()
                .supabase
                .from("branch")
                .update({'selected': true}).eq('id', branchId);
          }
        }

        if (event.isFreeTrial) {
          await getIt.get<DataLayer>().supabase.from("business").update({
            "free_trial": true,
          }).eq('id', getIt.get<DataLayer>().businessId!);
        }
      } catch (e) {
        emit(ErrorState());
      }

      getIt.get<DataLayer>().getBusinessInfo();
      emit(SubscriptionConfirmedState());
    });
  }

  int getBranchType() {
    final int numOfAdsPerBranch;
    if (planType == 'Enterprise') {
      numOfAdsPerBranch = 100;
    } else if (planType == 'Premium') {
      numOfAdsPerBranch = 5;
    } else {
      //basic
      numOfAdsPerBranch = 1;
    }
    return numOfAdsPerBranch;
  }
}
