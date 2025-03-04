import 'dart:ui';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          S.of(context).networks,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white.withAlpha(200),
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withAlpha(50),
              Theme.of(context).colorScheme.secondary.withAlpha(50),
            ],
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: networkBox.listenable(),
          builder: (context, Box<NetworkConfig> box, _) {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
              itemCount: box.length,
              itemBuilder: (context, index) {
                final record = box.getAt(index);
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(12),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Dismissible(
                      key: Key(record!.uid),
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(200),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        box.deleteAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${S.of(context).deleted} ${record.ssid}',
                            ),
                          ),
                        );
                      },
                      child: Material(
                        color: Colors.white.withAlpha(200),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          title: Text(
                            record.ssid,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              DateFormat(
                                'yyyy-MM-dd HH:mm',
                              ).format(record.time ?? DateTime(0)),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondary.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(150),
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
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withAlpha(75),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
