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
      this.price = 1000000,
      this.rating = 5,
      this.title = "Default tittle",
      this.description = "Hello this is a default description",
      this.imagesURLs = const [
        "https://i5.walmartimages.com/asr/fb99a428-7731-4a00-9764-c3997dbcbe71.a98b7d12c2c2b90236bf5ad3e5985433.jpeg"
      ]});
}
