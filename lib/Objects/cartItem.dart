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
    listOfItems.add(item);
  }
}
