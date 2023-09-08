import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';

class AverageComponent extends StatelessWidget {
  const AverageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(() => [roomState.value]);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('Average: ${roomState.value.average?.average ?? ''}'),
          const SizedBox(width: 10),
          Text(
            '(SD = ${roomState.value.average?.sd ?? ''})',
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
