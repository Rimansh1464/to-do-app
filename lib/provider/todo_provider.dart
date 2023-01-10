
import 'package:flutter/cupertino.dart';
import 'package:to_do_app/helpers/Db_helper.dart';
import 'package:to_do_app/models/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  Future<List<todoModel>>? fetchList ;

  fetchData(){
    fetchList = DBHelper.dbHelper.fetchapp();
    notifyListeners();
  }

}