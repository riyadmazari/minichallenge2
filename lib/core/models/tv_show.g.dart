// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TVShowAdapter extends TypeAdapter<TVShow> {
  @override
  final int typeId = 1;

  @override
  TVShow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TVShow(
      id: fields[0] as int,
      name: fields[1] as String,
      posterPath: fields[2] as String,
      overview: fields[3] as String,
      firstAirDate: fields[4] as String,
      voteAverage: fields[5] as double,
      genres: (fields[6] as List).cast<String>(),
      numberOfSeasons: fields[7] as int,
      numberOfEpisodes: fields[8] as int,
      cast: (fields[9] as List).cast<CastMember>(),
      director: fields[10] as String?,
      pegiRating: fields[11] as String?,
      episodeRunTime: (fields[12] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, TVShow obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.overview)
      ..writeByte(4)
      ..write(obj.firstAirDate)
      ..writeByte(5)
      ..write(obj.voteAverage)
      ..writeByte(6)
      ..write(obj.genres)
      ..writeByte(7)
      ..write(obj.numberOfSeasons)
      ..writeByte(8)
      ..write(obj.numberOfEpisodes)
      ..writeByte(9)
      ..write(obj.cast)
      ..writeByte(10)
      ..write(obj.director)
      ..writeByte(11)
      ..write(obj.pegiRating)
      ..writeByte(12)
      ..write(obj.episodeRunTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TVShowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
