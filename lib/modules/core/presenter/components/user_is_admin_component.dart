import 'package:flutter/material.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';

class UserIsAdminComponent extends StatelessWidget {
  const UserIsAdminComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
