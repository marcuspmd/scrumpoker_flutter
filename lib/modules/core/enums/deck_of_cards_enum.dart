import 'package:flutter/material.dart';
import 'package:scrumpoker_flutter/modules/core/entities/card_entity.dart';

enum DeckOfCardsEnum {
  mountainGoatPack,
  fibonacci,
  sequential,
}

extension DeckOfCardsEnumExtension on DeckOfCardsEnum {
  static const names = {
    DeckOfCardsEnum.mountainGoatPack: 'Mountain Goat Pack',
    DeckOfCardsEnum.fibonacci: 'Fibonacci',
    DeckOfCardsEnum.sequential: 'Sequential',
  };

  static Map<DeckOfCardsEnum, List<CardEntity>> decks = {
    DeckOfCardsEnum.mountainGoatPack: [
      CardEntity(label: '0', value: 0, selected: false),
      CardEntity(label: '1/2', value: 0.5, selected: false),
      CardEntity(label: '1', value: 1, selected: false),
      CardEntity(label: '2', value: 2, selected: false),
      CardEntity(label: '3', value: 3, selected: false),
      CardEntity(label: '5', value: 5, selected: false),
      CardEntity(label: '8', value: 8, selected: false),
      CardEntity(label: '13', value: 13, selected: false),
      CardEntity(label: '20', value: 20, selected: false),
      CardEntity(label: '40', value: 40, selected: false),
      CardEntity(label: '100', value: 100, selected: false),
      CardEntity(
          label: 'Coffee', value: -1, selected: false, icon: Icons.coffee),
    ],
    DeckOfCardsEnum.fibonacci: [
      CardEntity(label: '0', value: 0, selected: false),
      CardEntity(label: '1', value: 1, selected: false),
      CardEntity(label: '2', value: 2, selected: false),
      CardEntity(label: '3', value: 3, selected: false),
      CardEntity(label: '5', value: 5, selected: false),
      CardEntity(label: '8', value: 8, selected: false),
      CardEntity(label: '13', value: 13, selected: false),
      CardEntity(label: '21', value: 21, selected: false),
      CardEntity(label: '34', value: 34, selected: false),
      CardEntity(label: '55', value: 55, selected: false),
      CardEntity(label: '89', value: 89, selected: false),
      CardEntity(
          label: 'Coffee', value: -1, selected: false, icon: Icons.coffee),
    ],
    DeckOfCardsEnum.sequential: [
      CardEntity(label: '0', value: 0, selected: false),
      CardEntity(label: '1', value: 1, selected: false),
      CardEntity(label: '2', value: 2, selected: false),
      CardEntity(label: '3', value: 3, selected: false),
      CardEntity(label: '4', value: 4, selected: false),
      CardEntity(label: '5', value: 5, selected: false),
      CardEntity(label: '6', value: 6, selected: false),
      CardEntity(label: '7', value: 7, selected: false),
      CardEntity(label: '8', value: 8, selected: false),
      CardEntity(label: '9', value: 9, selected: false),
      CardEntity(label: '10', value: 10, selected: false),
      CardEntity(
          label: 'Coffee', value: -1, selected: false, icon: Icons.coffee),
    ]
  };

  String get label => names[this] ?? '';
  List<CardEntity> get deck => decks[this] ?? [];
}
