import 'package:asp/asp.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/entities/average_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/card_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';
import 'package:scrumpoker_flutter/modules/core/enums/deck_of_cards_enum.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/cache.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/repository/room_repository.dart';

class CoreReduce extends Reducer {
  final Cache prefs;
  final RoomRepository roomRepository;
  late CardEntity? lastSelectedCardState;

  CoreReduce({required this.prefs, required this.roomRepository}) {
    _initialize();
    on(() => [joinRoomAction], _joinRoom);
    on(() => [changeSchema], _changeSchema);
    on(() => [changeDeckOfCardsAction], _changeDeckOfCards);
    on(() => [selectCard], _selectCard);
    on(() => [updateUsers], _updateUsers);
    on(() => [userVoted], _userVoted);
    on(() => [clearAction], _clear);
    on(() => [clearAllAction], _clearAll);
    on(() => [removeUserAction], _removeUser);
    on(() => [addUserAction], _addUser);
    on(() => [updateSd], _updateSd);
    on(() => [updateSpectator], _updateSpectator);
    on(() => [updateImSpectator], _updateImSpectator);
    on(() => [showVotes], _showVotes);
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
    selectCard.value = null;

    if (joinRoomAction.value != null) {
      roomRepository.connect();
      RoomEntity room = roomRepository.emitJoinRoom(joinRoomAction.value!);
      roomState.value = room;
    }
  }

  _changeSchema() {
    darkModeState.value = !darkModeState.value;
    prefs.setBool('darkMode', darkModeState.value);
  }

  _changeDeckOfCards() {
    bool isOtherDeck = deckOfCardsState.value != changeDeckOfCardsAction.value;
    if (isOtherDeck) {
      clearAllAction();
      prefs.setString('deckOfCards', changeDeckOfCardsAction.value.label);
      deckOfCardsState.value = changeDeckOfCardsAction.value;
      roomRepository.emitChangeDeckOfCards(deckOfCardsState.value.label);
    }
  }

  _selectCard() {
    if (selectCard.value == null) {
      selectedCardState.value = null;
      return;
    }

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
    roomRepository.emitVote(vote);
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
    selectCard.value = null;
    roomState.value = roomState.value
        .copyWith(
          average: roomState.value.average?.copyWith(average: null, sd: null),
          isVoting: true,
          users: roomState.value.users.map((e) {
            return e.copyWith(isVoted: false, vote: null);
          }).toList(),
        )
        .clearAverage();
  }

  void _clearAll() {
    roomRepository.emitClear();
    _clear();
  }

  void _removeUser() {
    String? userId = removeUserAction.value;
    if (userId == null) {
      return;
    }
    roomState.value = roomState.value.copyWith(
      users: roomState.value.users.where((e) => e.id != userId).toList(),
    );
  }

  void _addUser() {
    Map<String, dynamic>? userMap = addUserAction.value;
    if (userMap == null) {
      return;
    }
    UserEntity user = UserEntity.fromMap(userMap);
    roomState.value = roomState.value.copyWith(
      users: roomState.value.users..add(user),
    );
  }

  void _updateSd() {
    Map<String, dynamic>? sdMap = updateSd.value;
    if (sdMap == null) {
      return;
    }
    AverageEntity average = AverageEntity.fromMap(sdMap);
    roomState.value =
        roomState.value.copyWith(average: average, isVoting: false);
  }

  void _updateSpectator() {
    Map<String, dynamic>? spectatorMap = updateSpectator.value;
    if (spectatorMap == null) {
      return;
    }
    UserEntity spectator = UserEntity.fromMap(spectatorMap);
    roomState.value = roomState.value.copyWith(
      users: roomState.value.users.map((e) {
        if (e.id == spectator.id) {
          return e.copyWith(
              isSpectator: spectator.isSpectator, isVoted: spectator.isVoted);
        }
        return e;
      }).toList(),
    );
  }

  void _updateImSpectator() {
    bool isSpectator = updateImSpectator.value;
    roomState.value = roomState.value.copyWith(
      myUser: roomState.value.myUser.copyWith(isSpectator: isSpectator),
    );
    selectCard.value = null;
    roomRepository.emitIsSpectator();
  }

  void _showVotes() {
    roomRepository.emitShowVotes();
  }
}
