import 'dart:math';

import 'package:flutter/foundation.dart';

import 'album.dart';

class CartItem {
  late Album item;
  late int quantity;

  CartItem(this.item, this.quantity);
}

class ListOfCartItems with ChangeNotifier {
  late List<CartItem> listOfItems;
  int subTotal = 0, shippingFees = 0, total = 0;

  ListOfCartItems() {
    listOfItems = [];
    Random rnd;
    rnd = new Random();
    shippingFees = 5 + rnd.nextInt(5);

    total = shippingFees;
    subTotal = 0;
    notifyListeners();
  }

  addItemToList(CartItem item) {
    for (int i = 0; i < listOfItems.length; i++) {
      // if item is already in cart
      if (listOfItems.elementAt(i).item.name == item.item.name) {
        // just increase the quantity
        listOfItems.elementAt(i).quantity++;
        // update final prices
        subTotal += item.item.price;
        total += item.item.price;
        notifyListeners();

        return;
      }
    }
    // if item was not already in cart, add it and update final prices
    listOfItems.add(item);
    subTotal += item.item.price;
    total += item.item.price;
    notifyListeners();
  }

  popItemFromList(CartItem item) {
    for (int i = 0; i < listOfItems.length; i++) {
      // if item is already in cart
      if (listOfItems.elementAt(i).item.name == item.item.name) {
        // just decrease the quantity
        listOfItems.elementAt(i).quantity--;
        // if quantity is now 0, remove item from list
        if (listOfItems.elementAt(i).quantity == 0) {
          listOfItems.remove(item);
        }
        // update final prices
        subTotal -= item.item.price;
        total -= item.item.price;
        notifyListeners();

        return;
      }
    }
  }

  clearQueue() {
    for (int i = 0; i < listOfItems.length; i++) {
      listOfItems.remove(listOfItems[i]);
      i--;
    }
    total = shippingFees;
    subTotal = 0;
    notifyListeners();
  }
}
