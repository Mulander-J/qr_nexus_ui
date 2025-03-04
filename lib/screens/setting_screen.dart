import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../widgets/language_switcher.dart';
import '../generated/l10n.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  PackageInfo? appInfo;

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appInfo = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          S.of(context).setting,
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
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
        children: [
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    S.of(context).appName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    appInfo?.appName ?? "",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    S.of(context).version,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    appInfo?.version ?? "",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    S.of(context).lang,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: const LanguageSwitcher(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
