class Ransaction{
  final int price;
  final int quantity;
  final String receiverUid;
  final String senderUid;
  final int totalPrice;
  final int stemLength;
  final List<String> photoUrl;
  final String companyName;
  final String datePicked;
  final int flowerColour;
  final String flowerType;
  final String invoiceUrl;


  Ransaction({this.price, this.quantity,this.receiverUid,this.senderUid,this.totalPrice, this.stemLength,
    this.photoUrl,this.companyName,this.datePicked,this.flowerColour, this.flowerType, this.invoiceUrl});
}
