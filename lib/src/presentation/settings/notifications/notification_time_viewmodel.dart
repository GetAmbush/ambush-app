import 'package:ambush_app/src/domain/models/day_time.dart';
import 'package:ambush_app/src/domain/usecases/get_notification_time.dart';
import 'package:ambush_app/src/domain/usecases/save_notification_time.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'notification_time_viewmodel.g.dart';

@injectable
class NotificationTimeViewModel extends _NotificationTimeViewModelBase
    with _$NotificationTimeViewModel {
  NotificationTimeViewModel(
      super.getNotificationTime, super.saveNotificationTime);
}

abstract class _NotificationTimeViewModelBase with Store {
  final IGetNotificationTime _getNotificationTime;
  final ISaveNotificationTime _saveNotificationTime;

  _NotificationTimeViewModelBase(
      this._getNotificationTime, this._saveNotificationTime) {
    var initialData = _getNotificationTime.get();
    dayController.text = initialData.day.toString();
    hourController.text = initialData.hour.toString();
    minuteController.text = initialData.minute.toString();
  }

  final dayController = TextEditingController();
  final hourController = TextEditingController();
  final minuteController = TextEditingController();

  int? _day;
  int? _hour;
  int? _minute;

  @action
  void didSelectDay(int day) {
    _day = day;
    dayController.text = day.toString();
  }

  @action
  void didSelectHour(int hour) {
    _hour = hour;
    hourController.text = hour.toString();
  }

  @action
  void didSelectMinute(int minute) {
    _minute = minute;
    minuteController.text = minute.toString();
  }

  DayTime get _notificationTime => DayTime(_day ?? 1, _hour ?? 0, _minute ?? 0);

  Future<void> saveInfo() async =>
      await _saveNotificationTime.save(_notificationTime);
}
