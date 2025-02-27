import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './models/network_config.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NetworkConfigAdapter());
  await Hive.openBox<NetworkConfig>('networkBox');
  runApp(const MyApp());
}
