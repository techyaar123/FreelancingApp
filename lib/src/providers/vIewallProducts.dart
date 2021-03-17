import 'package:flutter/cupertino.dart';

enum PageLayout { initial, viewAll, onlyclient }

class ViewAllProducts with ChangeNotifier {
  PageLayout _pageLayout = PageLayout.initial;
  PageLayout get pagelayout => _pageLayout;

  void viewallpages() {
    _pageLayout = PageLayout.viewAll;
    print(_pageLayout);
    notifyListeners();
  }

  void onlyClientsPage() {
    _pageLayout = PageLayout.onlyclient;
    print(_pageLayout);

    notifyListeners();
  }
}
