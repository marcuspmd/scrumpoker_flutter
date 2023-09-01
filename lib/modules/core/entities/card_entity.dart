import 'package:dson_adapter/dson_adapter.dart';
import 'package:flutter/material.dart';

class CardEntity {
  final String label;
  final double value;
  final bool selected;
  final IconData? icon;

  CardEntity({
    required this.label,
    required this.value,
    required this.selected,
    this.icon,
  });

  CardEntity copyWith({
    String? label,
    double? value,
    bool? selected,
    IconData? icon,
  }) {
    return CardEntity(
      label: label ?? this.label,
      value: value ?? this.value,
      selected: selected ?? this.selected,
      icon: icon ?? this.icon,
    );
  }

  CardEntity fromMap(Map<String, dynamic> map) {
    const dson = DSON();
    return dson.fromJson(map, CardEntity.new);
  }
}
