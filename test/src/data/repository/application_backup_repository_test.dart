import 'package:ambush_app/src/data/datasource/local_datasource.dart';
import 'package:ambush_app/src/data/repositories/application_backup_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../models/models_mocks.dart';

@GenerateNiceMocks([MockSpec<ILocalDataSource>()])
import 'application_backup_repository_test.mocks.dart';

void main() {
  late MockILocalDataSource mockLocalDataSource;
  late ApplicationBackupRepository sut;

  setUp() {
    mockLocalDataSource = MockILocalDataSource();
    sut = ApplicationBackupRepository(mockLocalDataSource);
  }

  group('ApplicationBackupRepository', () {
    setUp();
    test('test get - should save info', () {
      // Given
      when(mockLocalDataSource.getCompanyInfo()).thenReturn(mockCompanyInfo);
      when(mockLocalDataSource.getClientInfo()).thenReturn(mockClientInfo);
      when(mockLocalDataSource.getServiceInfo()).thenReturn(mockServiceInfo);
      when(mockLocalDataSource.getBankInfo()).thenReturn(mockBankInfo);
      when(mockLocalDataSource.getInvoiceList()).thenReturn(mockInvoiceList);
      // When
      final backup = sut.get();
      // Then
      expect(backup,
          '{"clientInfo":{"name":"Name","address":"Address"},"serviceInfo":{"description":"Description","quantity":0.0,"currencyName":"Currency","currencySymbol":"Symbol","currencyCC":"CC","price":10.0},"bankInfo":{"beneficiaryName":"Name","iban":"123","swift":"123","bankName":"123","bankAddress":"Address","intermediaryIban":null,"intermediarySwift":null,"intermediaryBankName":null,"intermediaryBankAddress":null},"companyInfo":{"name":"Name","address":{"street":"St","extraInfo":null,"neighbourhood":"Neighbourhood","city":"City","state":"State","country":"Country","zipCode":"Zip code"},"email":"email@email.com","ownerName":"Owner","cnpj":"123"},"invoiceList":[{"id":1,"issueDate":1,"dueDate":1,"createdAt":1,"updatedAt":1,"serviceInfo":{"description":"Description","quantity":0.0,"currencyName":"Currency","currencySymbol":"Symbol","currencyCC":"CC","price":10.0},"companyInfo":{"name":"Name","address":{"street":"Street","extraInfo":null,"neighbourhood":"Neighbourhood","city":"City","state":"State","country":"country","zipCode":"zipCode"},"email":"email@email.com","ownerName":"ownerName","cnpj":"cnpj"},"clientInfo":{"name":"name","address":"address"},"bankInfo":{"beneficiaryName":"beneficiaryName","iban":"iban","swift":"swift","bankName":"bankName","bankAddress":"bankAddress","intermediaryIban":null,"intermediarySwift":null,"intermediaryBankName":null,"intermediaryBankAddress":null}}]}');
    });

    test('test save - should send correct hive models', () async {
      // When
      await sut.restore(
          '{"clientInfo":{"name":"Name","address":"Address"},"serviceInfo":{"description":"Description","quantity":0.0,"currencyName":"Currency","currencySymbol":"Symbol","currencyCC":"CC","price":10.0},"bankInfo":{"beneficiaryName":"Name","iban":"123","swift":"123","bankName":"123","bankAddress":"Address","intermediaryIban":null,"intermediarySwift":null,"intermediaryBankName":null,"intermediaryBankAddress":null},"companyInfo":{"name":"Name","address":{"street":"St","extraInfo":null,"neighbourhood":"Neighbourhood","city":"City","state":"State","country":"Country","zipCode":"Zip code"},"email":"email@email.com","ownerName":"Owner","cnpj":"123"},"invoiceList":[{"id":1,"issueDate":1,"dueDate":1,"createdAt":1,"updatedAt":1,"serviceInfo":{"description":"Description","quantity":0.0,"currencyName":"Currency","currencySymbol":"Symbol","currencyCC":"CC","price":10.0},"companyInfo":{"name":"Name","address":{"street":"Street","extraInfo":null,"neighbourhood":"Neighbourhood","city":"City","state":"State","country":"country","zipCode":"zipCode"},"email":"email@email.com","ownerName":"ownerName","cnpj":"cnpj"},"clientInfo":{"name":"name","address":"address"},"bankInfo":{"beneficiaryName":"beneficiaryName","iban":"iban","swift":"swift","bankName":"bankName","bankAddress":"bankAddress","intermediaryIban":null,"intermediarySwift":null,"intermediaryBankName":null,"intermediaryBankAddress":null}}]}');
      // Then
      verify(mockLocalDataSource.clearDB()).called(1);
      verify(mockLocalDataSource.saveBankInfo(any)).called(1);
      verify(mockLocalDataSource.saveClientInfo(any)).called(1);
      verify(mockLocalDataSource.saveCompanyInfo(any)).called(1);
      verify(mockLocalDataSource.saveServiceInfo(any)).called(1);
      verify(mockLocalDataSource.saveInvoice(any)).called(1);
    });
  });
}
