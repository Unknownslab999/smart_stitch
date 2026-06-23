class PortfolioItem {
  const PortfolioItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;
}

class ProviderReview {
  const ProviderReview({
    required this.customerName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  final String customerName;
  final double rating;
  final String comment;
  final String date;
}
