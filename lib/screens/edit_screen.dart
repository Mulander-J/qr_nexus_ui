import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../models/network_config.dart';
import 'package:uuid/uuid.dart';

class EditScreen extends StatefulWidget {
  final NetworkConfig? record;
  final Function(NetworkConfig) onSave;

  const EditScreen({super.key, this.record, required this.onSave});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();
  String _uid = '';
  String _encryption = 'WPA2';

  @override
  void initState() {
    super.initState();
    if (widget.record != null) {
      _ssidController.text = widget.record!.ssid;
      _passwordController.text = widget.record!.password;
      _encryption = widget.record!.encryption;
      _uid = widget.record!.uid;
    } else {
      _uid = Uuid().v4();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.record == null ? S.of(context).create : S.of(context).edit,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSave(
                  NetworkConfig(
                    uid: _uid,
                    ssid: _ssidController.text,
                    password: _passwordController.text,
                    encryption: _encryption,
                    time: DateTime.now(),
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: S.of(context).ssid),
                controller: _ssidController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).pleaseEnterSsid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: S.of(context).password),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).pleaseEnterPassword;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _encryption,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: S.of(context).encryption,
                ),
                items:
                    ['WEP', 'WPA', 'WPA2'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _encryption = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
