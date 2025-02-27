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
      appBar: AppBar(title: Text(S.of(context).setting)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 应用名称
          ListTile(
            title: Text(
              S.of(context).appName,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Text(
              appInfo?.appName ?? "", // 替换为实际的应用名称
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          const Divider(), // 分隔线
          // 版本号 + 更新按钮
          ListTile(
            title: Text(
              S.of(context).version,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Text(
              appInfo?.version ?? "",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          const Divider(), // 分隔线
          // 语言切换
          ListTile(
            title: Text(
              S.of(context).lang,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const LanguageSwitcher(),
          ),
          const Divider(), // 分隔线
        ],
      ),
    );
  }
}
