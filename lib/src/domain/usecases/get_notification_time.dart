import 'package:ambush_app/src/data/repositories/notification_repository.dart';
import 'package:ambush_app/src/domain/models/day_time.dart';
import 'package:injectable/injectable.dart';

abstract class IGetNotificationTime {
  DayTime get();
}

@Singleton(as: IGetNotificationTime)
class GetNotificationTime implements IGetNotificationTime {
  final INotificationRepository _repository;

  GetNotificationTime(this._repository);

  @override
  DayTime get() => _repository.getNotificationTime();
}
