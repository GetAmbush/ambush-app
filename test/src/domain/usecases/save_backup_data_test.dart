import 'package:ambush_app/src/data/repositories/application_backup_repository.dart';
import 'package:ambush_app/src/domain/usecases/save_backup_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_backup_data_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IApplicationBackupRepository>()])
void main() {
  late IApplicationBackupRepository mockApplicationDataRepository;
  late SaveBackupData sut;

  setUp() {
    mockApplicationDataRepository = MockIApplicationBackupRepository();
    sut = SaveBackupData(mockApplicationDataRepository);
  }

  group('SaveBackupData', () {
    setUp();
    test('test save - should output be string', () async {
      await sut.save('String');
      verify(mockApplicationDataRepository.save('String'));
    });
  });
}
