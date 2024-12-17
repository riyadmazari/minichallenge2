// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CastMemberAdapter extends TypeAdapter<CastMember> {
  @override
  final int typeId = 3;

  @override
  CastMember read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CastMember(
      id: fields[0] as int,
      name: fields[1] as String,
      profilePath: fields[2] as String?,
      character: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CastMember obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.profilePath)
      ..writeByte(3)
      ..write(obj.character);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastMemberAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
