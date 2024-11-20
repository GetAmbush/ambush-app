import 'package:ambush_app/src/data/repositories/application_backup_repository.dart';
import 'package:ambush_app/src/domain/usecases/get_backup_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_backup_data_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IApplicationBackupRepository>()])
void main() {
  late IApplicationBackupRepository mockApplicationBackupRepository;
  late GetBackupData sut;

  setUp() {
    mockApplicationBackupRepository = MockIApplicationBackupRepository();
    sut = GetBackupData(mockApplicationBackupRepository);
  }

  group('GetBackupData', () {
    setUp();
    test('test get - should return string', () async {
      when(mockApplicationBackupRepository.get()).thenReturn('String');
      expect(await sut.get(), 'String');
    });
  });
}
