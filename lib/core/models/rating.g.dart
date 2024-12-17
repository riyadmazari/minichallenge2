// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RatingAdapter extends TypeAdapter<Rating> {
  @override
  final int typeId = 4;

  @override
  Rating read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rating(
      id: fields[0] as int,
      category: fields[1] as String,
      title: fields[2] as String,
      posterPath: fields[3] as String,
      userRating: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Rating obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.userRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
