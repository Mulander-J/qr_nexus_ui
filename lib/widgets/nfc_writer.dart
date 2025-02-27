import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter/services.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:ndef/record.dart';
import 'package:ndef/utilities.dart';
import '../generated/l10n.dart';

class WriteNfcWidget extends StatefulWidget {
  final String data;

  const WriteNfcWidget({super.key, required this.data});

  @override
  State<WriteNfcWidget> createState() => _WriteNfcWidgetState();
}

class _WriteNfcWidgetState extends State<WriteNfcWidget> {
  String _status = S.current.nfc_status_ready;
  bool _isWriting = false;

  Future<void> _writeNfc() async {
    setState(() {
      _isWriting = true;
      _status = S.of(context).nfc_status_start;
    });

    try {
      // 检查设备是否支持 NFC
      final availability = await FlutterNfcKit.nfcAvailability;
      if (availability != NFCAvailability.available) {
        setState(() {
          _status = S.of(context).nfc_status_unavaliable;
        });
        return;
      }

      setState(() {
        _status = S.of(context).nfc_status_writing;
      });

      final tag = await FlutterNfcKit.poll(
        timeout: Duration(seconds: 10),
        iosAlertMessage: S.current.nfc_ios_alert_holding,
        androidPlatformSound: true,
      );
      if (tag.ndefAvailable == true) {
        await FlutterNfcKit.writeNDEFRecords([
          ndef.NDEFRecord(
            tnf: TypeNameFormat.nfcWellKnown,
            payload: widget.data.toBytes(),
            type: "text/plain".toBytes(),
          ),
        ]);
        setState(() {
          _status = S.of(context).nfc_status_success;
        });
      } else {
        setState(() {
          _status = S.of(context).nfc_status_ndef_unsupport;
        });
      }

      // 结束 NFC 会话
      await FlutterNfcKit.finish(
        iosAlertMessage: S.current.nfc_ios_alert_finished,
        iosErrorMessage: S.current.nfc_ios_alert_error,
      );
    } on PlatformException catch (e) {
      setState(() {
        _status = 'Error: ${e.message}';
      });
    } finally {
      setState(() {
        _isWriting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).nfcWrite)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _status,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isWriting ? null : _writeNfc,
                child: Text(S.of(context).writingStatus(_isWriting)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
