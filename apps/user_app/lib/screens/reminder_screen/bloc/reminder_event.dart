
class ReminderEvent {
  const ReminderEvent();
}

class LoadReminders extends ReminderEvent {}

class RemoveReminder extends ReminderEvent {
  final Map reminder;

  RemoveReminder(this.reminder);
}