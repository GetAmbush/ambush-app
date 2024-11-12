import 'package:ambush_app/src/domain/models/day_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_day_time.g.dart';

@HiveType(typeId: 8)
class HiveDayTime extends HiveObject {
  @HiveField(0, defaultValue: 1)
  int day;

  @HiveField(1, defaultValue: 0)
  int hour;

  @HiveField(2, defaultValue: 0)
  int minute;

  HiveDayTime({this.day = 3, this.hour = 0, this.minute = 0});

  factory HiveDayTime.fromDomainModel(DayTime time) =>
      HiveDayTime(day: time.day, hour: time.hour, minute: time.minute);

  DayTime toDomainModel() => DayTime(day, hour, minute);
}
