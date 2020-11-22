class Offer {
  final double price;
  final double quantity;
  final String receiverUid;
  final String senderUid;
  final double totalPrice;
  final int stemLength;
  final List<String> photoUrl;
  final String companyName;
  final String datePicked;
  final int flowerColour;
  final String flowerType;

  Offer(
      {this.price,
      this.quantity,
      this.receiverUid,
      this.senderUid,
      this.totalPrice,
      this.stemLength,
      this.photoUrl,
      this.companyName,
      this.datePicked,
      this.flowerColour,
      this.flowerType});
}
