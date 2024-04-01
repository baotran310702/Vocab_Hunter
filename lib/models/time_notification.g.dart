// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeNotificationAdapter extends TypeAdapter<TimeNotification> {
  @override
  final int typeId = 15;

  @override
  TimeNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeNotification(
      title: fields[0] as String,
      time: fields[1] as TimeOfDay,
      isActive: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TimeNotification obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
