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
    context.select(() => [room.value, deckOfCards.value, selectedCard.value]);
    List<CardEntity> deck = deckOfCards.value.deck;
    List<UserEntity> users =
        room.value.users.where((e) => e.isSpectator == false).toList();
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Scrum Poker ${room.value.id}'),
            actions: ActionHeaderComponent.build(context)),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            color: darkMode.value ? Colors.white : Colors.black,
                            width: 0.3,
                          ),
                        ),
                        shadowColor: Colors.black,
                        color: deck[index] == selectedCard.value
                            ? Colors.grey[500]
                            : null,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          onTap: () {
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
                const Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(users[index].id),
                      subtitle: Text(users[index].isVoted
                          ? users[index].vote.toString()
                          : 'Not voted'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
