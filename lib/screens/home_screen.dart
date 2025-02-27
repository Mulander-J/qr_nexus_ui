import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../generated/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/network_config.dart';
import 'detail_screen.dart';
import 'edit_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box<NetworkConfig> networkBox = Hive.box<NetworkConfig>('networkBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).networks),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: networkBox.listenable(),
        builder: (context, Box<NetworkConfig> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final record = box.getAt(index);
              return Dismissible(
                key: Key(record!.uid),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  box.deleteAt(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${S.of(context).deleted} ${record.ssid}'),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ListTile(
                      title: Text(record.ssid),
                      subtitle: Text(
                        DateFormat(
                          'yyyy-MM-dd HH:mm',
                        ).format(record.time ?? DateTime(0)),
                      ),
                      onTap:
                          () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => DetailScreen(index: index),
                              ),
                            ),
                          },
                    ),
                    const Divider(height: 1, thickness: 1),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      EditScreen(onSave: (record) => networkBox.add(record)),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
