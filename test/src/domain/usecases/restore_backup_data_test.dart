import 'package:ambush_app/src/data/repositories/application_backup_repository.dart';
import 'package:ambush_app/src/domain/usecases/restore_backup_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_backup_data_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IApplicationBackupRepository>()])
void main() {
  late IApplicationBackupRepository mockApplicationDataRepository;
  late RestoreBackupData sut;

  setUp() {
    mockApplicationDataRepository = MockIApplicationBackupRepository();
    sut = RestoreBackupData(mockApplicationDataRepository);
  }

  group('SaveBackupData', () {
    setUp();
    test('test save - should output be string', () async {
      // When
      await sut.restore('String');
      // Then
      verify(mockApplicationDataRepository.restore('String'));
    });
  });
}
