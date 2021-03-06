class CartItem {
  final String buyerUID;
  final String flowerType;
  final int quantity;
  final int flowerColour;
  final String datePicked;
  final String dateAddedToCart;
  final String companyName;
  final String supplierUID;
  final List<String> photoUrl;
  final int stemLength;

  CartItem(
      {this.companyName,
      this.datePicked,
      this.flowerColour,
      this.quantity,
      this.flowerType,
      this.supplierUID,
      this.buyerUID,
      this.dateAddedToCart,
      this.photoUrl,
      this.stemLength});
}
