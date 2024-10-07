class Clothe {
  int id;
  int userId;
  String description;
  String title;
  int price;
  int rating;
  List imagesURLs;

  Clothe(
      {this.id = 1,
      this.userId = 1,
      this.price = 100000,
      this.rating = 5,
      this.title = "Pantalones cuadriculados",
      this.description =
          "Estoy vendiendo estos pantalones cuadrados que le regalaron a mi hija pero no le gustaron, estan completamente nuevos y son de buena calidad",
      this.imagesURLs = const [
        "https://i5.walmartimages.com/asr/fb99a428-7731-4a00-9764-c3997dbcbe71.a98b7d12c2c2b90236bf5ad3e5985433.jpeg"
      ]});
}
