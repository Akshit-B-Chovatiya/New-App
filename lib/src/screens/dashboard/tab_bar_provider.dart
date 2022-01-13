import 'package:flutter/cupertino.dart';

class TabBarProvider with ChangeNotifier {
  int tabIndex = 1;

  changeTab({@required BuildContext? context, @required int? index}) async {
    tabIndex = index!;
    notifyListeners();
  }
}
