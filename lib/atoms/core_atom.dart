import 'package:asp/asp.dart';
import 'package:scrumpoker_flutter/modules/core/entities/card_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/enums/deck_of_cards_enum.dart';

// atoms
final room = Atom<RoomEntity>(RoomEntity.empty);
final loading = Atom(true);
final darkMode = Atom(false);
final deckOfCards = Atom(DeckOfCardsEnum.mountainGoatPack);
final selectedCard = Atom<CardEntity?>(null);

// actions
final changeSchema = Atom.action();
final joinRoom = Atom<String?>(null);
final changeDeckOfCards =
    Atom<DeckOfCardsEnum>(DeckOfCardsEnum.mountainGoatPack);
final selectCard = Atom<CardEntity?>(null);
