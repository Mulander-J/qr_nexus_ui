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
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SSID
                        Text(
                          '${S.of(context).ssid}: ${_record.ssid}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Password
                        Text(
                          '${S.of(context).password}: ${_record.password}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 12),
                        // Encryption (Chip)
                        Text(
                          '${S.of(context).encryption}: ${_record.encryption}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // 二维码源数据卡片
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S.of(context).qrcodeData}:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _record.qrCodeData,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: _record.qrCodeData),
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(S.of(context).copySuccess),
                                    ),
                                  );
                                }
                              },
                              child: Text(S.of(context).copy),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => WriteNfcWidget(
                                          data: _record.qrCodeData,
                                        ),
                                  ),
                                );
                              },
                              child: Text(S.of(context).nfcWrite),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        QrImageView(
                          data: _record.qrCodeData,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              shareQRImage(_record.qrCodeData);
                            },
                            child: Text(S.of(context).share),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text(S.of(context).qrcodeView),
          ),
        ),
      ),
    );
  }
}
