import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/main.dart';

class DetailProfile extends ConsumerWidget {
  const DetailProfile({super.key, required this.param1, this.param2 = false});
  final String param1;
  final bool param2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appState = ref.watch(appStateProvider);
    var userState = ref.watch(userStateProvider);
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text('Detail Profile'),
      ),
      body: Center(
        child: Column(children: [
          const Text('Detail Profile Screen'),
          Text('ROUTE PARAMS: {param1:$param1, param2: $param2}'),
          Text('APPSTATE: ${appState.count}'),
          Text(
              'USER_STATE: ${userState.username} - ${userState.age} - ${userState.isPremiumUser}'),
          ElevatedButton(
            onPressed: () {
              Random random = Random();
              final age = random.nextInt(100);
              ref.read(userStateProvider.notifier).updateAge(age);
            },
            child: const Text('UPDATE AGE OF USER'),
          )
        ]),
      ),
    );
  }
}
