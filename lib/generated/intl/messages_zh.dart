// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(isWriting) =>
      "${Intl.select(isWriting, {'true': '写入中...', 'other': '开始写入'})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("应用名称"),
    "copy": MessageLookupByLibrary.simpleMessage("复制"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("已复制到剪贴板"),
    "create": MessageLookupByLibrary.simpleMessage("新建"),
    "deleted": MessageLookupByLibrary.simpleMessage("已删除"),
    "edit": MessageLookupByLibrary.simpleMessage("编辑"),
    "encryption": MessageLookupByLibrary.simpleMessage("加密方式"),
    "lang": MessageLookupByLibrary.simpleMessage("语言"),
    "networkDetail": MessageLookupByLibrary.simpleMessage("网络详情"),
    "networks": MessageLookupByLibrary.simpleMessage("网络"),
    "nfcWrite": MessageLookupByLibrary.simpleMessage("NFC写入"),
    "nfc_ios_alert_error": MessageLookupByLibrary.simpleMessage("NFC连接出错"),
    "nfc_ios_alert_finished": MessageLookupByLibrary.simpleMessage("NFC连接关闭"),
    "nfc_ios_alert_holding": MessageLookupByLibrary.simpleMessage(
      "将NFC卡片紧紧贴在手机背面",
    ),
    "nfc_status_ndef_unsupport": MessageLookupByLibrary.simpleMessage(
      "卡片不支持NDEF",
    ),
    "nfc_status_ready": MessageLookupByLibrary.simpleMessage("准备"),
    "nfc_status_start": MessageLookupByLibrary.simpleMessage("正在连接NFC..."),
    "nfc_status_success": MessageLookupByLibrary.simpleMessage("数据写入成功!"),
    "nfc_status_unavaliable": MessageLookupByLibrary.simpleMessage("NFC不可用"),
    "nfc_status_writing": MessageLookupByLibrary.simpleMessage(
      "NFC连接成功.开始写入...",
    ),
    "nfc_write_btn": MessageLookupByLibrary.simpleMessage("开始写入"),
    "password": MessageLookupByLibrary.simpleMessage("密码"),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage("请输入密码"),
    "pleaseEnterSsid": MessageLookupByLibrary.simpleMessage("请输入SSID"),
    "qrcodeView": MessageLookupByLibrary.simpleMessage("二维码"),
    "setting": MessageLookupByLibrary.simpleMessage("设置"),
    "share": MessageLookupByLibrary.simpleMessage("分享"),
    "ssid": MessageLookupByLibrary.simpleMessage("SSID"),
    "version": MessageLookupByLibrary.simpleMessage("版本号"),
    "writingStatus": m0,
  };
}
