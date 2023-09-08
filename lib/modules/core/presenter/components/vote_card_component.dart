import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/entities/card_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';

class VoteCardComponent extends StatelessWidget {
  final UserEntity card;
  final List<CardEntity> deck;

  const VoteCardComponent({super.key, required this.card, required this.deck});

  @override
  Widget build(BuildContext context) {
    context.select(() => [darkModeState.value]);
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: darkModeState.value ? Colors.white : Colors.black,
          width: 0.3,
        ),
      ),
      shadowColor: Colors.black,
      child: Center(
        child: _cardContext(),
      ),
    );
  }

  Widget _cardContext() {
    if (!card.isVoted) {
      return const SizedBox.shrink();
    }
    if (roomState.value.isVoting) {
      return const Text('?');
    }

    if (card.vote == null) {
      return const Text('-');
    }

    CardEntity myCard =
        deck.firstWhere((e) => e.value == double.parse(card.vote!));
    if (myCard.icon != null) {
      return Icon(myCard.icon);
    }

    return Text(card.vote!);
  }
}
