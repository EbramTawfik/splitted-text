import 'package:flutter/cupertino.dart';
import 'package:page_split/constant.dart';
import 'package:page_split/logic/splittedText.dart';

class PageControlProvider extends ChangeNotifier {
  SplittedText _splittedText = SplittedText();
  Size _size;
  List<String> _splittedTextList = [];
  List<String> get splittedTextList => _splittedTextList;
  int _currentIndex = 0;

  updateSize(Size size) {
    _size = size;
  }

  getSplittedTextFromBloc(TextStyle textStyle) {
    _splittedTextList =
        _splittedText.getSplittedText(_size, textStyle, kSmapleText);
    notifyListeners();
  }

  set currentIndex(int idx) {
    _currentIndex = idx;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
}
