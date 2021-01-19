
class MiniCart {
  final String variantID;
  final String productID;
  int quantity;

  MiniCart(this.variantID, this.productID, this.quantity);

  updateQuantity(int val) {
    quantity = quantity + val;
  }

  incrementQuantity() {
    quantity = quantity + 1;
  }

  decrementQuantity() {
    if (quantity > 0) {
      quantity = quantity - 1;
    }
  }
}