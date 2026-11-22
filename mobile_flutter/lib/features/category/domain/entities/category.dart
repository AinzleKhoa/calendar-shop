// Lớp Category giữ trách nhiệm chính của file này.
class Category {
  final int categoryId;
  final String categoryName;
  final String? description;
  final String status;

  const Category({
    required this.categoryId,
    required this.categoryName,
    this.description,
    required this.status,
  });
}
