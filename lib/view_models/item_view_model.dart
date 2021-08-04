import 'package:flutter/widgets.dart';
import 'package:intern_project/models/item.dart';

import 'package:http/http.dart' as http;
import 'package:intern_project/widgets/toast.dart';

class ItemModel extends ChangeNotifier {
  final itemsURL = "http://192.168.1.107:3000/items";

  Future<List<dynamic>> getItemsByCat(int catID) async {
    var data;

    try {
      http.Response response = await http.get(itemsURL + "?catId=$catID");

      if (response.statusCode == 200) {
        data = itemFromJson(response.body);
        notifyListeners();
      } else {
        toastMsg("Could not fetch data. Try again!");
      }
    } catch (e) {
      toastMsg(e.toString());
    }
    return data;
  }

  Future<List<dynamic>> getItemsByCatAndLabel(int catID, int labelID) async {
    var data;

    try {
      http.Response response =
          await http.get(itemsURL + "?catId=$catID" + "&labelId=$labelID");

      if (response.statusCode == 200) {
        data = itemFromJson(response.body);
        notifyListeners();
      } else {
        toastMsg("Could not fetch data. Try again!");
      }
    } catch (e) {
      toastMsg(e.toString());
    }
    return data;
  }

  updateItem(Item item) async {
    try {
      http.Response response = await http.put(itemsURL + "/${item.id}",
          headers: {
            'Content-Type': 'application/json',
          },
          body: itemToJson(item));

      if (response.statusCode == 200) {
        // toastMsg("Done");
      } else {
        toastMsg("Could not update data. Try again!");
      }
    } catch (e) {
      toastMsg(e.toString());
    }
  }

  deleteItem(Item item) async {
    try {
      http.Response response = await http.delete(
        itemsURL + "/${item.id}",
      );

      if (response.statusCode == 200) {
        toastMsg("Successfully deleted the item.");
        notifyListeners();
      } else {
        toastMsg("Could not delete data. Try again!");
      }
    } catch (e) {
      toastMsg(e.toString());
    }
  }
}
