import 'package:ambush_app/src/data/repositories/application_backup_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IGetBackupData {
  Future<String> get();
}

@Injectable(as: IGetBackupData)
class GetBackupData implements IGetBackupData {
  final IApplicationBackupRepository _applicationBackupRepository;

  GetBackupData(this._applicationBackupRepository);

  @override
  Future<String> get() async => _applicationBackupRepository.get();
}
