class ReminderState {
  const ReminderState();
}

class ReminderLoading extends ReminderState {}

class ReminderLoaded extends ReminderState {
  final   List<Map<String, dynamic>> myReminders;

  ReminderLoaded({required this.myReminders});
}

class ReminderError extends ReminderState {}
class ReminderNoData extends ReminderState {}
class ReminderRemoved extends ReminderState {}
/*
class MyReminder {
  final String bannerimg;
  final String title;
  final String offer_type;
  final String description;
  final String id;

  MyReminder({
    required this.bannerimg,
    required this.id,
    required this.title,
    required this.offer_type,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'bannerimg': bannerimg,
      'title': title,
      'offer_type': offer_type,
      'description': description,
      'id': id,
    };
  }

  factory MyReminder.fromMap(Map<String, dynamic> map) {
    return MyReminder(
      bannerimg: map['bannerimg'],
      title: map['title'],
      offer_type: map['offer_type'],
      description: map['description'],
      id: map['id'],
    );
  }
}*/