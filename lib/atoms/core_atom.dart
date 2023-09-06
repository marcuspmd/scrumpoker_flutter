import 'package:asp/asp.dart';
import 'package:scrumpoker_flutter/modules/core/entities/card_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/enums/deck_of_cards_enum.dart';

// atoms
final roomState = Atom<RoomEntity>(RoomEntity.empty);
final loadingState = Atom(true);
final darkModeState = Atom(false);
final deckOfCardsState = Atom(DeckOfCardsEnum.mountainGoatPack);
final selectedCardState = Atom<CardEntity?>(null);
final myUserIdState = Atom<String?>(null);

// actions
final changeSchema = Atom.action();
final joinRoomAction = Atom<String?>(null);
final changeDeckOfCards =
    Atom<DeckOfCardsEnum>(DeckOfCardsEnum.mountainGoatPack);
final selectCard = Atom<CardEntity?>(null);
final updateUsers = Atom<List<dynamic>?>(null);
final userVoted = Atom<String?>(null);
final clearAction = Atom.action();
