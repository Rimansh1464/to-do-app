
import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier{
   bool isDark = false;

   ChangTheme(){
      isDark = !isDark;
      notifyListeners();
   }


}