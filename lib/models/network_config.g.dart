// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NetworkConfigAdapter extends TypeAdapter<NetworkConfig> {
  @override
  final int typeId = 0;

  @override
  NetworkConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NetworkConfig(
      uid: fields[0] as String,
      ssid: fields[1] as String,
      password: fields[2] as String,
      encryption: fields[3] as String,
      time: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NetworkConfig obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.ssid)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.encryption)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
