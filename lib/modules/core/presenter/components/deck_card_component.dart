import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/entities/card_entity.dart';

class DeckCardComponent extends StatelessWidget {
  final CardEntity card;

  const DeckCardComponent({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    context.select(() => [selectedCardState.value]);
    return Card(
      key: Key(
          'DeckCard:${card.label}:${darkModeState.value.toString()}:${selectedCardState.value.toString()}'),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: darkModeState.value ? Colors.white : Colors.black,
          width: 0.3,
        ),
      ),
      shadowColor: Colors.black,
      color: card == selectedCardState.value ? Colors.grey[500] : null,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: () {
          if (roomState.value.isVoting == false) {
            return;
          }
          selectCard.value = card;
        },
        child: Center(
          child: card.icon != null ? Icon(card.icon) : Text(card.label),
        ),
      ),
    );
  }
}
