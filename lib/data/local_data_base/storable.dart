import 'package:flutter/material.dart';

@immutable
abstract class Storable {
  const Storable(this.id, this.updatedAt, this.createdAt);

  final DateTime? createdAt;
  final String id;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Storable && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Storable(id: $id, updatedAt: $updatedAt, createdAt: $createdAt)';
}
