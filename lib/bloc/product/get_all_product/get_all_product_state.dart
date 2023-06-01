part of 'get_all_product_bloc.dart';

@immutable
abstract class GetAllProductState {}

class GetAllProductInitial extends GetAllProductState {}

class GetAllProductLoading extends GetAllProductState {}

class GetAllProductLoaded extends GetAllProductState {
  final List<ProductResponseModel> listProduct;
  GetAllProductLoaded({
    required this.listProduct,
  });
}
