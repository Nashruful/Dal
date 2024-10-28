import 'package:user_app/screens/reminder_screen/bloc/reminder_state.dart';

class ReminderEvent {
  const ReminderEvent();
}

class LoadReminders extends ReminderEvent {}

class RemoveReminder extends ReminderEvent {
  final Map reminder;

  RemoveReminder(this.reminder);
}