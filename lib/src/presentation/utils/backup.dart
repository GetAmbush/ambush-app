import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/presentation/utils/backup_error.dart';
import 'package:injectable/injectable.dart';

abstract class IBackup {
  Future<void> create(String data);
  Future<String> restore();
}

@injectable
class UnimplementedBackup implements IBackup {
  @override
  Future<void> create(String data) => throw BackupError(platformError);

  @override
  Future<String> restore() => throw BackupError(platformError);
}

@injectable
class MobileBackup implements IBackup {
  @override
  Future<void> create(String data) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<String> restore() {
    // TODO: implement restore
    throw UnimplementedError();
  }
}

@injectable
class DesktopBackup implements IBackup {
  @override
  Future<void> create(String data) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<String> restore() {
    // TODO: implement restore
    throw UnimplementedError();
  }
}

@injectable
class WebBackup implements IBackup {
  @override
  Future<void> create(String data) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<String> restore() {
    // TODO: implement restore
    throw UnimplementedError();
  }
}
