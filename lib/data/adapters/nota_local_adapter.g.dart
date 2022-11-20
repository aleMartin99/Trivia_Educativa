// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_local_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotaLocalAdaptAdapter extends TypeAdapter<NotaLocalAdapt> {
  @override
  final int typeId = 1;

  @override
  NotaLocalAdapt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotaLocalAdapt(
      nota: fields[5] as int?,
      idNotaProv: fields[0] as String?,
      idAsignatura: fields[1] as String?,
      idTema: fields[2] as String?,
      idNivel: fields[3] as String?,
      idEstudiante: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotaLocalAdapt obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.idNotaProv)
      ..writeByte(1)
      ..write(obj.idAsignatura)
      ..writeByte(2)
      ..write(obj.idTema)
      ..writeByte(3)
      ..write(obj.idNivel)
      ..writeByte(4)
      ..write(obj.idEstudiante)
      ..writeByte(5)
      ..write(obj.nota);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotaLocalAdaptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
