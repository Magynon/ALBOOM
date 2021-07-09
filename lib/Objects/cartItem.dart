import 'album.dart';

class CartItem {
  late Album item;
  late int quantity;

  CartItem(this.item, this.quantity);
}

class ListOfCartItems {
  late List<CartItem> listOfItems;

  ListOfCartItems() {
    listOfItems = [];
  }

  addItemToList(CartItem item) {
    for (int i = 0; i < listOfItems.length; i++) {
      if (listOfItems.elementAt(i).item.name == item.item.name) {
        listOfItems.elementAt(i).quantity += item.quantity;
        return;
      }
    }
    listOfItems.add(item);
  }

  clearQueue() {
    for (int i = 0; i < listOfItems.length; i++) {
      listOfItems.removeAt(i);
      i--;
    }
  }
}
