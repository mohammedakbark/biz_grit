class ItemModel {
  String id;
  String title;
  String wholesaleRate;
  String retailRate;
  String margin;

  ItemModel(
      {required this.id,
      required this.margin,
      required this.retailRate,
      required this.title,
      required this.wholesaleRate});
}
