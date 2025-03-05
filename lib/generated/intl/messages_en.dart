// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(isWriting) =>
      "${Intl.select(isWriting, {'true': 'Writing...', 'other': 'Write'})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("App Name"),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Copy Successed"),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "deleted": MessageLookupByLibrary.simpleMessage("Deleted"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "encryption": MessageLookupByLibrary.simpleMessage("Encryption"),
    "lang": MessageLookupByLibrary.simpleMessage("Language"),
    "networkDetail": MessageLookupByLibrary.simpleMessage("Network Detail"),
    "networks": MessageLookupByLibrary.simpleMessage("Networks"),
    "nfcWrite": MessageLookupByLibrary.simpleMessage("NFC Write"),
    "nfc_ios_alert_error": MessageLookupByLibrary.simpleMessage(
      "Error during NFC session",
    ),
    "nfc_ios_alert_finished": MessageLookupByLibrary.simpleMessage(
      "Session finished",
    ),
    "nfc_ios_alert_holding": MessageLookupByLibrary.simpleMessage(
      "Hold your phone near the NFC tag",
    ),
    "nfc_status_ndef_unsupport": MessageLookupByLibrary.simpleMessage(
      "Tag does not support NDEF",
    ),
    "nfc_status_ready": MessageLookupByLibrary.simpleMessage("Ready"),
    "nfc_status_start": MessageLookupByLibrary.simpleMessage(
      "Starting NFC session...",
    ),
    "nfc_status_success": MessageLookupByLibrary.simpleMessage(
      "Data written successfully!",
    ),
    "nfc_status_unavaliable": MessageLookupByLibrary.simpleMessage(
      "NFC not available",
    ),
    "nfc_status_writing": MessageLookupByLibrary.simpleMessage(
      "NFC session started. Writing data...",
    ),
    "nfc_write_btn": MessageLookupByLibrary.simpleMessage("Start Writing"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter password",
    ),
    "pleaseEnterSsid": MessageLookupByLibrary.simpleMessage(
      "Please enter SSID",
    ),
    "qrcodeView": MessageLookupByLibrary.simpleMessage("QR Code"),
    "setting": MessageLookupByLibrary.simpleMessage("Setting"),
    "share": MessageLookupByLibrary.simpleMessage("Share"),
    "ssid": MessageLookupByLibrary.simpleMessage("SSID"),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "writingStatus": m0,
  };
}
