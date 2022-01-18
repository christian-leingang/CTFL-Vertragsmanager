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
    return Vertrag()
      .._id = fields[0] as String?
      .._name = fields[1] as String
      .._label = fields[2] as Label
      .._beschreibung = fields[3] as String
      .._vertragspartner = fields[4] as String
      .._vertragsBeginn = fields[5] as DateTime?
      .._vertragsEnde = fields[6] as DateTime?
      .._kuendigungsfrist = fields[7] as DateTime?
      .._intervall = fields[8] as String
      .._beitrag = fields[9] as double?
      .._erstzahlung = fields[10] as DateTime?
      .._naechsteZahlung = fields[11] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Vertrag obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._name)
      ..writeByte(2)
      ..write(obj._label)
      ..writeByte(3)
      ..write(obj._beschreibung)
      ..writeByte(4)
      ..write(obj._vertragspartner)
      ..writeByte(5)
      ..write(obj._vertragsBeginn)
      ..writeByte(6)
      ..write(obj._vertragsEnde)
      ..writeByte(7)
      ..write(obj._kuendigungsfrist)
      ..writeByte(8)
      ..write(obj._intervall)
      ..writeByte(9)
      ..write(obj._beitrag)
      ..writeByte(10)
      ..write(obj._erstzahlung)
      ..writeByte(11)
      ..write(obj._naechsteZahlung);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VertragAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
