import 'package:ambush_app/src/data/repositories/notification_repository.dart';
import 'package:ambush_app/src/domain/models/day_time.dart';
import 'package:injectable/injectable.dart';

abstract class ISaveNotificationTime {
  Future<void> save(DayTime time);
}

@Injectable(as: ISaveNotificationTime)
class SaveNotificationTime implements ISaveNotificationTime {
  final INotificationRepository _repository;

  SaveNotificationTime(this._repository);

  @override
  Future<void> save(DayTime time) => _repository.saveNotificationTime(time);
}
