import 'package:injectable/injectable.dart';

abstract class IBackup {
  Future<bool> save();
  Future<bool> get();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  @override
  Future<bool> save() {
    throw UnimplementedError();
  }

  @override
  Future<bool> get() {
    throw UnimplementedError();
  }
}
