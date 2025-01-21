import 'package:flutter/material.dart';

import '../model/invite_friend_models.dart';


class FriendProvider extends ChangeNotifier {
  List<FriendModel> _friends = [];

  List<FriendModel> get friends => _friends;

  void addFriend(FriendModel friend) {
    _friends.add(friend);
    notifyListeners();
  }
}
