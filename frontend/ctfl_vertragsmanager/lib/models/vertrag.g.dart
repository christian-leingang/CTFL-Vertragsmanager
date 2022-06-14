// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vertrag.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VertragAdapter extends TypeAdapter<Vertrag> {
  @override
  final int typeId = 0;

  @override
  Vertrag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vertrag(
      name: fields[1] as String,
      beitrag: fields[9] as double,
      id: fields[0] as String?,
      label: fields[2] as Label?,
      beschreibung: fields[3] as String?,
      vertragspartner: fields[4] as String?,
      vertragsBeginn: fields[5] as DateTime?,
      vertragsEnde: fields[6] as DateTime?,
      kuendigungsfrist: fields[7] as DateTime?,
      intervall: fields[8] as String?,
      erstZahlung: fields[10] as DateTime?,
      pdfUrl: fields[12] as String?,
      pdfTitel: fields[13] as String?,
    )..naechsteZahlung = fields[11] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Vertrag obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.beschreibung)
      ..writeByte(4)
      ..write(obj.vertragspartner)
      ..writeByte(5)
      ..write(obj.vertragsBeginn)
      ..writeByte(6)
      ..write(obj.vertragsEnde)
      ..writeByte(7)
      ..write(obj.kuendigungsfrist)
      ..writeByte(8)
      ..write(obj.intervall)
      ..writeByte(9)
      ..write(obj.beitrag)
      ..writeByte(10)
      ..write(obj.erstZahlung)
      ..writeByte(11)
      ..write(obj.naechsteZahlung)
      ..writeByte(12)
      ..write(obj.pdfUrl)
      ..writeByte(13)
      ..write(obj.pdfTitel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VertragAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
