import 'package:flutter/cupertino.dart';
import 'package:techwise_pub/Views/pages/product_category.dart';

class GridOrListProvider extends ChangeNotifier{
 GridOrListSelector _selector = GridOrListSelector.grid;

 GridOrListSelector get selector => _selector;

  void toggle(GridOrListSelector selector) {
    _selector = selector;
    notifyListeners();
  }
}