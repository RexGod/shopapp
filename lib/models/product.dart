class Prodcut {
  final String id;
  final String title;
  final String description;
  final String imagUrl;
  final double price;
  bool isFavorite;

  Prodcut(
      {required this.id,
      required this.title,
      required this.description,
      required this.imagUrl,
      required this.price,
      this.isFavorite = false});
}
