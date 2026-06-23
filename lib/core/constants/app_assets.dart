abstract final class AppAssets {
  static const String logoIconOnly =
      'assets/images/Smart-Stitch_No Background_No Label.png';
  static const String logoWithLabel =
      'assets/images/Smart-Stitch_No Background_Contains Label.png';

  static const String dress1 = 'assets/images/Dresses/1.jpeg';
  static const String dress2 = 'assets/images/Dresses/2.jpeg';
  static const String dress3 = 'assets/images/Dresses/3.jpeg';
  static const String dress4 = 'assets/images/Dresses/4.jpeg';
  static const String dress5 = 'assets/images/Dresses/5.jpeg';
  static const String dress6 = 'assets/images/Dresses/6.jpeg';
  static const String dress7 = 'assets/images/Dresses/7.jpeg';
  static const String dress8 = 'assets/images/Dresses/8.jpeg';

  static const List<String> dresses = [
    dress1,
    dress2,
    dress3,
    dress4,
    dress5,
    dress6,
    dress7,
    dress8,
  ];

  static String dressAt(int index) => dresses[index % dresses.length];
}
