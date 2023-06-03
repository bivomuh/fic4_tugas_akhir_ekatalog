part of 'delete_product_bloc.dart';

@immutable
abstract class DeleteProductEvent {}

class DoDeleteProductEvent extends DeleteProductEvent {
  final int id;

  DoDeleteProductEvent({
    required this.id,
  });
}
