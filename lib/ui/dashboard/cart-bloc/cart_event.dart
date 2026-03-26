  abstract class CartEvent {}

  class AddToCartEvent extends CartEvent {
    int productId;
    int quantity;

    AddToCartEvent({required this.productId, required this.quantity});
  }

  class DecrementCartEvent extends CartEvent {
    int productId;
    int quantity;
    DecrementCartEvent({required this.productId, required this.quantity});
  }
