// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseDetailsEntityAdapter extends TypeAdapter<CourseDetailsEntity> {
  @override
  final int typeId = 0;

  @override
  CourseDetailsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseDetailsEntity(
      name: fields[0] as String,
      path: fields[1] as String?,
      size: fields[2] as String,
      extention: fields[3] as String?,
      date: fields[4] as String?,
      type: fields[5] as String?,
      id: fields[6] as int?,
      courseCode: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CourseDetailsEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.size)
      ..writeByte(3)
      ..write(obj.extention)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.courseCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseDetailsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
