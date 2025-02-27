// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Networks`
  String get networks {
    return Intl.message('Networks', name: 'networks', desc: '', args: []);
  }

  /// `Setting`
  String get setting {
    return Intl.message('Setting', name: 'setting', desc: '', args: []);
  }

  /// `Deleted`
  String get deleted {
    return Intl.message('Deleted', name: 'deleted', desc: '', args: []);
  }

  /// `Network Detail`
  String get networkDetail {
    return Intl.message(
      'Network Detail',
      name: 'networkDetail',
      desc: '',
      args: [],
    );
  }

  /// `QRCode Data`
  String get qrcodeData {
    return Intl.message('QRCode Data', name: 'qrcodeData', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `NFC Write`
  String get nfcWrite {
    return Intl.message('NFC Write', name: 'nfcWrite', desc: '', args: []);
  }

  /// `Check QRCode`
  String get qrcodeView {
    return Intl.message('Check QRCode', name: 'qrcodeView', desc: '', args: []);
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `SSID`
  String get ssid {
    return Intl.message('SSID', name: 'ssid', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Encryption`
  String get encryption {
    return Intl.message('Encryption', name: 'encryption', desc: '', args: []);
  }

  /// `Please enter SSID`
  String get pleaseEnterSsid {
    return Intl.message(
      'Please enter SSID',
      name: 'pleaseEnterSsid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Copy Successed`
  String get copySuccess {
    return Intl.message(
      'Copy Successed',
      name: 'copySuccess',
      desc: '',
      args: [],
    );
  }

  /// `App Name`
  String get appName {
    return Intl.message('App Name', name: 'appName', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Language`
  String get lang {
    return Intl.message('Language', name: 'lang', desc: '', args: []);
  }

  /// `{isWriting, select, true{Writing...} other{Write}}`
  String writingStatus(Object isWriting) {
    return Intl.select(
      isWriting,
      {'true': 'Writing...', 'other': 'Write'},
      name: 'writingStatus',
      desc: '',
      args: [isWriting],
    );
  }

  /// `Start Writing`
  String get nfc_write_btn {
    return Intl.message(
      'Start Writing',
      name: 'nfc_write_btn',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get nfc_status_ready {
    return Intl.message('Ready', name: 'nfc_status_ready', desc: '', args: []);
  }

  /// `Starting NFC session...`
  String get nfc_status_start {
    return Intl.message(
      'Starting NFC session...',
      name: 'nfc_status_start',
      desc: '',
      args: [],
    );
  }

  /// `NFC not available`
  String get nfc_status_unavaliable {
    return Intl.message(
      'NFC not available',
      name: 'nfc_status_unavaliable',
      desc: '',
      args: [],
    );
  }

  /// `NFC session started. Writing data...`
  String get nfc_status_writing {
    return Intl.message(
      'NFC session started. Writing data...',
      name: 'nfc_status_writing',
      desc: '',
      args: [],
    );
  }

  /// `Data written successfully!`
  String get nfc_status_success {
    return Intl.message(
      'Data written successfully!',
      name: 'nfc_status_success',
      desc: '',
      args: [],
    );
  }

  /// `Tag does not support NDEF`
  String get nfc_status_ndef_unsupport {
    return Intl.message(
      'Tag does not support NDEF',
      name: 'nfc_status_ndef_unsupport',
      desc: '',
      args: [],
    );
  }

  /// `Hold your phone near the NFC tag`
  String get nfc_ios_alert_holding {
    return Intl.message(
      'Hold your phone near the NFC tag',
      name: 'nfc_ios_alert_holding',
      desc: '',
      args: [],
    );
  }

  /// `Session finished`
  String get nfc_ios_alert_finished {
    return Intl.message(
      'Session finished',
      name: 'nfc_ios_alert_finished',
      desc: '',
      args: [],
    );
  }

  /// `Error during NFC session`
  String get nfc_ios_alert_error {
    return Intl.message(
      'Error during NFC session',
      name: 'nfc_ios_alert_error',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
