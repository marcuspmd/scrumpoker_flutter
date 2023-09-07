import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/entities/card_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';
import 'package:scrumpoker_flutter/modules/core/enums/deck_of_cards_enum.dart';
import 'package:scrumpoker_flutter/modules/core/presenter/components/action_header_component.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.select(() => [
          loadingState.value,
          roomState.value,
          deckOfCardsState.value,
          selectedCardState.value,
        ]);
    List<CardEntity> deck = deckOfCardsState.value.deck;
    List<UserEntity> users =
        roomState.value.users.where((e) => e.isSpectator == false).toList();
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Scrum Poker ${roomState.value.id}'),
            actions: ActionHeaderComponent.build(context)),
        body: SafeArea(
          child: loadingState.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: width > 700 ? 12 : 6,
                            childAspectRatio: 0.7,
                          ),
                          shrinkWrap: true,
                          itemCount: deck.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: darkModeState.value
                                      ? Colors.white
                                      : Colors.black,
                                  width: 0.3,
                                ),
                              ),
                              shadowColor: Colors.black,
                              color: deck[index] == selectedCardState.value
                                  ? Colors.grey[500]
                                  : null,
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                onTap: () {
                                  if (roomState.value.isVoting == false) {
                                    return;
                                  }

                                  selectCard.value = deck[index];
                                },
                                child: Center(
                                  child: deck[index].icon != null
                                      ? Icon(deck[index].icon)
                                      : Text(deck[index].label),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Switch(
                                value: roomState.value.myUser.isSpectator,
                                onChanged: (value) =>
                                    updateImSpectator.value = value),
                            const Text('I\'m Spectator'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: width > 700 ? 12 : 6,
                            childAspectRatio: 0.7,
                          ),
                          shrinkWrap: true,
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: darkModeState.value
                                      ? Colors.white
                                      : Colors.black,
                                  width: 0.3,
                                ),
                              ),
                              shadowColor: Colors.black,
                              child: Center(
                                child: users[index].isVoted
                                    ? Text(roomState.value.isVoting
                                        ? '?'
                                        : users[index].vote ?? '-')
                                    : const SizedBox.shrink(),
                              ),
                            );
                          },
                        ),
                      ),
                      roomState.value.average != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                      'Average: ${roomState.value.average?.average ?? ''}'),
                                  const SizedBox(width: 10),
                                  Text(
                                    '(SD = ${roomState.value.average?.sd ?? ''})',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      roomState.value.myUser.isAdmin
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                        const Size(300, 50),
                                      ),
                                    ),
                                    onPressed: () => showVotes(),
                                    child: const Text('Show Votes'),
                                  ),
                                  const SizedBox(height: 20),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                        const Size(300, 50),
                                      ),
                                    ),
                                    onPressed: () => clearAllAction(),
                                    child: const Text('Clear'),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
