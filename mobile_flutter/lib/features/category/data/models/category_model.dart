import '../../domain/entities/category.dart';

// Lớp CategoryModel giữ trách nhiệm chính của file này.
class CategoryModel extends Category {
  const CategoryModel({
    required super.categoryId,
    required super.categoryName,
    super.description,
    required super.status,
  });

  // Parse JSON từ backend sang model Dart.
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'] ?? '',
      description: json['description'],
      status: json['status'] ?? 'Active',
    );
  }

  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  Category toEntity() => Category(
        categoryId: categoryId,
        categoryName: categoryName,
        description: description,
        status: status,
      );
}
