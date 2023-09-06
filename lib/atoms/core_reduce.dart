import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';
import 'package:scrumpoker_flutter/modules/core/enums/deck_of_cards_enum.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/cache.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/repository/room_repository.dart';

class CoreReduce extends Reducer {
  final Cache prefs;
  final RoomRepository roomRepository;

  CoreReduce({required this.prefs, required this.roomRepository}) {
    _initialize();
    on(() => [joinRoomAction], _joinRoom);
    on(() => [changeSchema], _changeSchema);
    on(() => [changeDeckOfCards], _changeDeckOfCards);
    on(() => [selectCard], _selectCard);
    on(() => [updateUsers], _updateUsers);
    on(() => [userVoted], _userVoted);
    on(() => [clearAction], _clear);
  }

  _initialize() async {
    bool initialDarkMode = prefs.getBool('darkMode');
    String initialDeckOfCards = 'Mountain Goat Pack';
    initialDeckOfCards = prefs.getString('deckOfCards');
    if (initialDeckOfCards.isNotEmpty) {
      deckOfCardsState.value = DeckOfCardsEnum.values
          .firstWhere((element) => element.label == initialDeckOfCards);
    }
    darkModeState.value = initialDarkMode;
  }

  _joinRoom() async {
    loadingState.value = true;
    selectedCardState.value = null;

    if (joinRoomAction.value != null) {
      RoomEntity? room = roomRepository.joinRoom(joinRoomAction.value);
      if (room != null) {
        roomState.value = room;
        Modular.to.pushNamed('/room/');
      }

      return;
    }
    roomRepository.newRoom();
  }

  _changeSchema() {
    darkModeState.value = !darkModeState.value;
    prefs.setBool('darkMode', darkModeState.value);
  }

  _changeDeckOfCards() {
    bool isOtherDeck = deckOfCardsState.value != changeDeckOfCards.value;
    if (isOtherDeck) {
      selectedCardState.value = null;
      _updateUserVote(null, false);
      deckOfCardsState.value = changeDeckOfCards.value;
      roomRepository.changeDeckOfCards(deckOfCardsState.value.label);
    }
  }

  _selectCard() {
    if (selectedCardState.value == selectCard.value) {
      selectCard.value = null;
    }
    _updateUserVote(
        selectCard.value?.value.toString(), selectCard.value != null);
    selectedCardState.value = selectCard.value;
  }

  _updateUsers() {
    if (updateUsers.value == null) {
      return;
    }
    List<dynamic> users = updateUsers.value!;
    if (users.isEmpty) {
      return;
    }

    for (var userMap in users) {
      UserEntity user = UserEntity.fromMap(userMap);
      roomState.value.users.removeWhere((e) => e.id == user.id);
      if (user.id == myUserIdState.value) {
        roomState.value = roomState.value.copyWith(myUser: user);
      }
      roomState.value.users.add(user);
      roomState();
    }
  }

  _updateUserVote(String? vote, bool isVoted) {
    roomRepository.vote(vote);
    roomState.value = roomState.value.copyWith(
      users: roomState.value.users.map((e) {
        if (e.id == roomState.value.myUser.id) {
          return e.copyWith(isVoted: isVoted, vote: vote);
        }
        return e;
      }).toList(),
    );
  }

  void _userVoted() {
    String? userId = userVoted.value;
    if (userId == null) {
      return;
    }
    roomState.value = roomState.value.copyWith(
      users: roomState.value.users.map((e) {
        if (e.id == userId) {
          return e.copyWith(isVoted: true);
        }
        return e;
      }).toList(),
    );
  }

  void _clear() {
    selectedCardState.value = null;
    roomState.value = roomState.value.copyWith(
      users: roomState.value.users.map((e) {
        return e.copyWith(isVoted: false, vote: null);
      }).toList(),
    );
  }
}
