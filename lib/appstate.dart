import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _showSplash = true;

  bool get showSplash => _showSplash;

  void hideSplash() {
    _showSplash = false;
    notifyListeners();
  }
}
