import 'package:injectable/injectable.dart';

abstract class IBackup {
  Future<void> save();
  Future<void> recover();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  @override
  Future<void> save() {
    throw UnimplementedError();
  }

  @override
  Future<void> recover() {
    throw UnimplementedError();
  }
}
