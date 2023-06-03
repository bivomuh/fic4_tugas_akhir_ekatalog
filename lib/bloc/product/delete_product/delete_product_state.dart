part of 'delete_product_bloc.dart';

@immutable
abstract class DeleteProductState {}

class DeleteProductInitial extends DeleteProductState {}

class DeleteProductLoading extends DeleteProductState {}

class DeleteProductLoaded extends DeleteProductState {
  final int id;
  DeleteProductLoaded({
    required this.id,
  });
}
