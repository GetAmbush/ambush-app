import 'package:ambush_app/src/data/datasource/local_datasource.dart';
import 'package:ambush_app/src/domain/models/day_time.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:platform_local_notifications/platform_local_notifications.dart';

abstract class INotificationRepository {
  Future<void> initialize();
  Future<bool?> askNotificationPermission();
  Future<void> showInvoiceNotification(BuildContext context);
  DayTime getNotificationTime();
  Future<void> saveNotificationTime(DayTime time);
}

@Singleton(as: INotificationRepository)
class NotificationRepository implements INotificationRepository {
  final ILocalDataSource _source;

  NotificationRepository(this._source);

  @override
  Future<void> initialize() async =>
      await PlatformNotifier.I.init(appName: "Ambush");

  @override
  Future<bool?> askNotificationPermission() async =>
      await PlatformNotifier.I.requestPermissions();

  @override
  Future<void> showInvoiceNotification(BuildContext context) async =>
      await PlatformNotifier.I.showPluginNotification(
          ShowPluginNotificationModel(
              id: DateTime.now().second,
              title: "title",
              body: "body",
              payload: "test"),
          context);

  @override
  DayTime getNotificationTime() =>
      _source.getNotificationTime().toDomainModel();

  @override
  Future<void> saveNotificationTime(DayTime time) async =>
      _source.saveNotificationTime(time);
}
