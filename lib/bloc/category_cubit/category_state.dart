part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final List<CategoryModel> categories;

  final RequestState? getCategoriesState;
  const CategoryState(
      {this.categories = const [],
      this.getCategoriesState });

  @override
  List<Object?> get props => [categories, getCategoriesState];
}
