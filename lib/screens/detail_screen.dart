import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import '../generated/l10n.dart';
import '../models/network_config.dart';
import 'edit_screen.dart';
import '../widgets/nfc_writer.dart';

class DetailScreen extends StatefulWidget {
  final int index;

  const DetailScreen({super.key, required this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Box networkBox;
  late NetworkConfig _record;

  @override
  void initState() {
    super.initState();
    networkBox = Hive.box<NetworkConfig>('networkBox');
    _record = networkBox.getAt(widget.index);
  }

  Future<void> shareQRImage(String data) async {
    if (kIsWeb) {
      // Web 平台，分享文本
      await Share.share(data);
    } else {
      // 创建二维码图片
      final qrPainter = QrPainter(data: data, version: QrVersions.auto);
      final picture = qrPainter.toPicture(200);
      final image = await picture.toImage(200, 200);

      // 保存二维码图片到临时文件
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/qr_code.png');
      await file.writeAsBytes(byteData!.buffer.asUint8List());

      // 分享图片
      // await Share.shareFiles([file.path]);
      await Share.shareXFiles([XFile(file.path)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).networkDetail),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => EditScreen(
                        record: _record,
                        onSave: (updatedRecord) {
                          setState(() {
                            _record = updatedRecord;
                          });
                          networkBox.putAt(widget.index, updatedRecord);
                        },
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            // 网络信息卡片
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withAlpha(75),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20.0,
                        20.0,
                        20.0,
                        20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SSID
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${S.of(context).ssid}: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _record.ssid,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy),
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () async {
                                  await Clipboard.setData(
                                    ClipboardData(text: _record.ssid),
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(S.of(context).copySuccess),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Password
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${S.of(context).password}: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Expanded(
                                child: Wrap(
                                  spacing: 0,
                                  runSpacing: 4,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: _record.password.split('').map((char) {
                                    Color color;
                                    if (RegExp(r'[0-9]').hasMatch(char)) {
                                      color = Colors.red;
                                    } else if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
                                      color = Colors.black;
                                    } else {
                                      color = Colors.blue;
                                    }
                                    return Text(
                                      char,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: color,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy),
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () async {
                                  await Clipboard.setData(
                                    ClipboardData(text: _record.password),
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(S.of(context).copySuccess),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Encryption
                          Row(
                            children: [
                              Text(
                                '${S.of(context).encryption}: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Text(
                                _record.encryption,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.nfc),
                label: Text(S.of(context).nfcWrite),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => WriteNfcWidget(data: _record.qrCodeData),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.qr_code),
                label: Text(S.of(context).qrcodeView),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 24),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Hero(
                              tag: 'qr_code_${_record.uid}',
                              child: QrImageView(
                                data: _record.qrCodeData,
                                version: QrVersions.auto,
                                size: 200.0,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.share),
                                label: Text(S.of(context).share),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  shareQRImage(_record.qrCodeData);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
