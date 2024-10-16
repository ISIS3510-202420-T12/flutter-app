import 'dart:math';

class Clothe {
  int id;
  int userId;
  late String description; // 'late' permite la inicialización diferida
  late String title; // 'late' para el título
  int price;
  int rating;
  late List<String> imagesURLs; // 'late' para la lista de imágenes

  Clothe({
    int? id,
    int? userId,
    int? price,
    int? rating,
    String? title,
    String? description,
    List<String>? imagesURLs,
  })  : this.id = id ?? 1,
        this.userId = userId ?? 1,
        this.price =
            price ?? Random().nextInt(100000) + 10000, // Precio aleatorio
        this.rating = rating ?? Random().nextInt(5) + 1 {
    // Llamar a la función una vez para obtener el título, la descripción y las imágenes coherentes
    Map<String, dynamic> randomClothingItem = _randomClothingItem();

    // Asignación usando los valores aleatorios
    this.title = title ?? randomClothingItem['title'];
    this.description = description ?? randomClothingItem['description'];
    this.imagesURLs = imagesURLs ?? randomClothingItem['images'];
  }

  // Lista de títulos, descripciones e imágenes coherentes
  static Map<String, dynamic> _randomClothingItem() {
    List<Map<String, dynamic>> clothingItems = [
      {
        "title": "Pantalones Cuadriculados",
        "description":
            "Pantalones cuadriculados para hombre, nuevos y a la moda. Ideales para salidas casuales.",
        "images": [
          "https://i5.walmartimages.com/asr/fb99a428-7731-4a00-9764-c3997dbcbe71.a98b7d12c2c2b90236bf5ad3e5985433.jpeg"
        ]
      },
      {
        "title": "Camisa a rayas",
        "description":
            "Camisa a rayas para ocasiones formales o casuales. En perfecto estado, apenas usada.",
        "images": [
          "https://m.media-amazon.com/images/I/71wF0tJtf2L._AC_UL1500_.jpg"
        ]
      },
      {
        "title": "Camiseta deportiva",
        "description":
            "Camiseta ligera y cómoda, ideal para actividades deportivas. Viene en talla M.",
        "images": [
          "https://http2.mlstatic.com/camisetas-deportivas-para-hombre-adidas-nike-under-armour-D_NQ_NP_735838-MCO29244501225_012019-F.jpg"
        ]
      },
      {
        "title": "Chaqueta de cuero",
        "description":
            "Chaqueta de cuero genuino, poco uso. Perfecta para el invierno o para salidas nocturnas.",
        "images": [
          "https://images-na.ssl-images-amazon.com/images/I/81IJuVmysaL._AC_UL1500_.jpg"
        ]
      },
      {
        "title": "Zapatos de vestir",
        "description":
            "Zapatos de vestir para hombre, talla 42, en perfecto estado. Usados solo una vez.",
        "images": [
          "https://cdn.shopify.com/s/files/1/0234/4461/products/french-bulldog-kids-socks-model_400x.jpg?v=1667325940"
        ]
      }
    ];
    // Selección aleatoria
    return clothingItems[Random().nextInt(clothingItems.length)];
  }
}
