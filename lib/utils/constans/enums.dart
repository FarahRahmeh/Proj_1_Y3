enum Genres {
  fantasy,
  romance,
  poetry,
  drama,
  literature,
  fairyTalesFolklore,
  mystery,
  thriller,
  horror,
  adventure,
  crime,
  comics,
  manga,
  humor,
  scienceFiction,
  science,
  technology,
  travel,
  religion,
  history,
  philosophy,
  psychology,
  lifeStories,
  health,
  business,
  selfHelp,
  education,
  childrensLiterature,
  pictureBook,
  youngAdult,
}

enum TextSizes { small, medium, large }
/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */

/// Switch of Custom Brand-Text-Size Widget
enum AppRole { admin, user }

enum TransactionType { buy, sell }

enum ProductType { single, variable }

enum ProductVisibility { published, hidden }

enum ImageType { asset, network, memory, file }

enum MediaCategory { folders, banners, brands, categories, products, users }

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm
}
