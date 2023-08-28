import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.select(() => [darkMode.value]);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Scrum Poker'), actions: [
        IconButton(
          onPressed: () {
            changeSchema();
          },
          icon: darkMode.value
              ? const Icon(Icons.light_mode)
              : const Icon(Icons.dark_mode),
        ),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        )
      ]),
      body: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Distributed scrum planning poker for estimating agile projects.'),
                      Text('Create a room and invite your team to join.'),
                      Text('Start a new round and let the team vote.'),
                      Text('See the results and discuss the outcome.'),
                    ]),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.7,
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {},
                                ),
                                border: const OutlineInputBorder(),
                                labelText: 'Room ID',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('or'),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Create a room'),
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
    ));
  }
}
