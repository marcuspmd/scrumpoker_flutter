import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/entities/card_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';
import 'package:scrumpoker_flutter/modules/core/enums/deck_of_cards_enum.dart';
import 'package:scrumpoker_flutter/modules/core/presenter/components/action_header_component.dart';
import 'package:scrumpoker_flutter/modules/core/presenter/components/average_component.dart';
import 'package:scrumpoker_flutter/modules/core/presenter/components/deck_card_component.dart';
import 'package:scrumpoker_flutter/modules/core/presenter/components/user_is_admin_component.dart';
import 'package:scrumpoker_flutter/modules/core/presenter/components/vote_card_component.dart';

class RoomPage extends StatelessWidget {
  final String roomId;

  RoomPage({
    super.key,
    required this.roomId,
  }) {
    joinRoomAction.value = roomId;
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [
          loadingState.value,
          roomState.value,
          deckOfCardsState.value,
        ]);
    List<CardEntity> deck = deckOfCardsState.value.deck;
    List<UserEntity> users =
        roomState.value.users.where((e) => e.isSpectator == false).toList();
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Scrum Poker'),
            actions: ActionHeaderComponent.build(context)),
        body: SafeArea(
          child: loadingState.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Room id: ${roomState.value.id}'),
                            const SizedBox(width: 10),
                            InkWell(
                                onTap: () async => await Clipboard.setData(
                                    ClipboardData(text: roomState.value.id)),
                                child: const Icon(Icons.copy))
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
                          itemCount: deck.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DeckCardComponent(card: deck[index]);
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
                            const Text('I\'m spectator'),
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
                            return VoteCardComponent(
                              card: users[index],
                              deck: deck,
                            );
                          },
                        ),
                      ),
                      roomState.value.average != null
                          ? const AverageComponent()
                          : const SizedBox.shrink(),
                      roomState.value.myUser.isAdmin
                          ? const UserIsAdminComponent()
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
