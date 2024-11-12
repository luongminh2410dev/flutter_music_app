import 'package:flutter/material.dart';
import 'package:music_app/ui/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Định nghĩa UserStateProvider
class UserState {
  String username;
  bool isPremiumUser;
  int age;

  UserState(
      {this.username = "Guest", this.isPremiumUser = false, this.age = 0});
}

// Tạo provider cho AppState
final userStateProvider =
    StateNotifierProvider<UserStateNotifier, UserState>((ref) {
  return UserStateNotifier();
});

// Sử dụng StateNotifier để quản lý state
class UserStateNotifier extends StateNotifier<UserState> {
  UserStateNotifier() : super(UserState());

  void updateUsername(String newUsername) {
    state =
        UserState(username: newUsername, isPremiumUser: state.isPremiumUser);
  }

  void togglePremiumStatus() {
    state = UserState(
        username: state.username, isPremiumUser: !state.isPremiumUser);
  }

  void updateAge(int age) {
    state = UserState(
      username: state.username,
      isPremiumUser: state.isPremiumUser,
      age: age,
    );
  }
}

class AppState {
  int count;

  AppState({this.count = 0});
}

// Tạo provider cho AppState
final appStateProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});

// Sử dụng StateNotifier để quản lý state
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void countUp() {
    state = AppState(count: state.count + 1);
  }

  void countDown() {
    state = AppState(count: state.count - 1);
  }
}

void main() => runApp(const ProviderScope(child: MusicApp()));
