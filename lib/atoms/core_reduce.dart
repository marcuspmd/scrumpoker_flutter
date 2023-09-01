import 'package:asp/asp.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/enums/deck_of_cards_enum.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/cache.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/repository/room_repository.dart';

class CoreReduce extends Reducer {
  final Cache prefs;
  final RoomRepository roomRepository;

  CoreReduce({required this.prefs, required this.roomRepository}) {
    bool initialDarkMode = prefs.getBool('darkMode');
    String initialDeckOfCards = 'Mountain Goat Pack';
    initialDeckOfCards = prefs.getString('deckOfCards');
    if (initialDeckOfCards.isNotEmpty) {
      deckOfCards.value = DeckOfCardsEnum.values
          .firstWhere((element) => element.label == initialDeckOfCards);
    }
    darkMode.value = initialDarkMode;
    on(() => [joinRoom], _joinRoom);
    on(() => [changeSchema], _changeSchema);
    on(() => [changeDeckOfCards], _changeDeckOfCards);
    on(() => [selectCard], _selectCard);
  }

  _joinRoom() async {
    loading.value = true;
    selectedCard.value = null;
    RoomEntity roomResult = await roomRepository.joinRoom(joinRoom.value);

    room.value = roomResult;
    loading.value = false;
  }

  _changeSchema() {
    darkMode.value = !darkMode.value;
    prefs.setBool('darkMode', darkMode.value);
  }

  _changeDeckOfCards() {
    bool isOtherDeck = deckOfCards.value != changeDeckOfCards.value;
    if (isOtherDeck) {
      selectedCard.value = null;
      deckOfCards.value = changeDeckOfCards.value;
      roomRepository.changeDeckOfCards(deckOfCards.value.label);
    }
  }

  _selectCard() {
    if (selectedCard.value == selectCard.value) {
      selectedCard.value = null;
      return;
    }
    room.value = room.value.copyWith(
      users: room.value.users.map((e) {
        if (e.id == room.value.myUser.id) {
          return e.copyWith(
              isVoted: selectCard.value != null,
              vote: selectCard.value!.value.toString());
        }
        return e;
      }).toList(),
    );
    selectedCard.value = selectCard.value;
    // roomRepository.vote(selectedCard.value!.label);
  }
}
