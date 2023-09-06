import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/enums/deck_of_cards_enum.dart';

class ActionHeaderComponent {
  static List<Widget> build(BuildContext context) {
    context.select(() => [darkModeState.value, deckOfCardsState.value]);
    return [
      IconButton(
        onPressed: () {
          changeSchema();
        },
        icon: darkModeState.value
            ? const Icon(Icons.light_mode)
            : const Icon(Icons.dark_mode),
      ),
      PopupMenuButton(
          child: Row(
            children: [
              Text(deckOfCardsState.value.label),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
          onSelected: (value) => changeDeckOfCards.value = value,
          itemBuilder: (_) {
            return DeckOfCardsEnum.values
                .map((e) => PopupMenuItem(
                      value: e,
                      child: Text(e.label),
                    ))
                .toList();
          }),
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      )
    ];
  }
}
