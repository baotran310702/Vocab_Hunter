import 'package:english_learner/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final typeId = KeyHiveLocal.hiveTimeOfDay;

  @override
  TimeOfDay read(BinaryReader reader) {
    final hour = reader.readByte();
    final minute = reader.readByte();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay time) {
    writer.writeByte(time.hour);
    writer.writeByte(time.minute);
  }
}
