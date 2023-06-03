part of 'update_product_bloc.dart';

@immutable
abstract class UpdateProductState {}

class UpdateProductInitial extends UpdateProductState {}

class UpdateProductLoading extends UpdateProductState {}

class UpdateProductLoaded extends UpdateProductState {
  final ProductResponseModel productResponseModel;
  final int id;
  UpdateProductLoaded({
    required this.productResponseModel,
    required this.id,
  });
}
