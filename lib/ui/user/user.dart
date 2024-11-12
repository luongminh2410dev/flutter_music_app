import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/main.dart';

class UserTab extends ConsumerWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appState = ref.watch(appStateProvider);
    var userState = ref.watch(userStateProvider);
    final age = userState.age;

    return Scaffold(
      appBar: const CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User Tab'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('detail-profile',
                    arguments: {'param1': 'User123', 'param2': true});
              },
              child: const Text('NAVIGATE TO DETAIL PROFILE'),
            ),
            const SizedBox(height: 24),
            Text('APPSTATE: ${appState.count}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(appStateProvider.notifier).countUp();
                  },
                  child: const Text('Count Up'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    ref.read(appStateProvider.notifier).countDown();
                  },
                  child: const Text('Count Down'),
                )
              ],
            ),
            const SizedBox(height: 24),
            Text(
                'USER_STATE: ${userState.username} - $age - ${userState.isPremiumUser}')
          ],
        ),
      ),
    );
  }
}
