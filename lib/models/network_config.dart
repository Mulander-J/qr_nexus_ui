import 'package:hive/hive.dart';

part 'network_config.g.dart';

@HiveType(typeId: 0)
class NetworkConfig {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String ssid;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String encryption;

  @HiveField(4)
  final DateTime? time;

  NetworkConfig({
    required this.uid,
    required this.ssid,
    required this.password,
    required this.encryption,
    this.time,
  });

  String get qrCodeData => 'WIFI:S:$ssid;T:$encryption;P:$password;;';
}
