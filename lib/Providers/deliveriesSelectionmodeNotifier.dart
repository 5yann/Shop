// ignore_for_file: prefer_final_fields, file_names

import 'package:flutter/material.dart';

class SelectionModeNotifier extends ChangeNotifier {
  bool _isSelectionMode = false;
  Set<String> _selectedItems = {};

  bool get isSelectionMode => _isSelectionMode;
  Set<String> get selectedItems => _selectedItems;

  void toggleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    if (!_isSelectionMode ) {
      _selectedItems.clear();
    }
    notifyListeners();
  }

  void toggleItemSelection(String index) {
    if (_selectedItems.contains(index)) {
      _selectedItems.remove(index);
    } else {
      _selectedItems.add(index);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedItems.clear();
    notifyListeners();
  }
}
