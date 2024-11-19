import 'package:hive/hive.dart';
import 'package:ambush_app/src/domain/models/client_info.dart';

part 'hive_client_info.g.dart';

@HiveType(typeId: 4)
class HiveClientInfo extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String address;

  HiveClientInfo(this.name, this.address);

  ClientInfo toClientInfo() => ClientInfo(name, address);

  static HiveClientInfo from(ClientInfo clientInfo) => HiveClientInfo(
        clientInfo.name,
        clientInfo.address,
      );
}
