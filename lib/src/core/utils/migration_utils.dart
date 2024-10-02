import 'package:ambush_app/src/data/datasource/local_datasource.dart';
import 'package:injectable/injectable.dart';

// This is the version of the database schema
const _dbVersion = 2;

@Singleton()
class MigrationUtils  {
  final ILocalDataSource _source;

  MigrationUtils(this._source);

  Future checkAndMigrateDbIfNeeded() async {
    // This is the current version of the database (the one running in the user's device)
    final currentVersion = _source.getDbVersion();

    // If the current version is less than the version we want to migrate to, we start the migration
    if (currentVersion < _dbVersion) {
      _startMigration(currentVersion);
      await _source.setDbVersion(_dbVersion);
    }
  }

  void _startMigration(int currentVersion) {
    if (currentVersion == 1) {
      _migrateFrom1To2();
    }
  }

  // Destructive migration
  void _migrateFrom1To2() {
    _source.clearDB();
  }
}
