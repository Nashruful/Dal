import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';
import 'reminder_event.dart';
import 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final dataLayer = getIt.get<DataLayer>();

  ReminderBloc() : super(ReminderLoading()) {
    on<LoadReminders>(onLoadReminders);
    on<RemoveReminder>(onRemoveReminder);
  }

  void onLoadReminders(LoadReminders event, Emitter<ReminderState> emit) async {
    

    try {
      // await dataLayer.getUserInfo();

      //  if (dataLayer.currentUserInfo != null) {
      final remindersResponse =  dataLayer.myReminders;

      /*await dataLayer.supabase
            .from("ad")
            .select();*/
      //  .eq("user_id", dataLayer.currentUserInfo!['id'])
      
      if (remindersResponse.isNotEmpty) {
        // final List<dynamic> remindersData = remindersResponse as List<dynamic>;

        //      List<Map<String, dynamic>> myReminders = remindersResponse;
        /*remindersData.map((reminderData) {
            return MyReminder(
              bannerimg: reminderData['bannerimg'] ?? 'assets/svg/coffee.svg',
              title: reminderData['title'] ?? '',
              offer_type: reminderData['offer_type'] ?? '', description: '--',
               id: reminderData['id'] ?? '',
              
            );
          }).toList();*/

        ///     emit(ReminderLoaded(myReminders: myReminders));
      } else {
        emit(ReminderNoData());
      }
      //} else {
      //   emit(ReminderError());
      //   }
    } catch (e) {
      emit(ReminderError());
    }
  }

  void onRemoveReminder(
      RemoveReminder event, Emitter<ReminderState> emit) async {
    try {
      // final response = await dataLayer.supabase.from("ad")
      //     .delete()
      //     .eq("id", event.reminder.id)
      //   ;
      final response = dataLayer.myReminders.remove(event.reminder);

      if (response) {
        emit(ReminderRemoved());
      } else {
        emit(ReminderError());
      }
    } catch (e) {
      emit(ReminderError());
    }
  }
}
