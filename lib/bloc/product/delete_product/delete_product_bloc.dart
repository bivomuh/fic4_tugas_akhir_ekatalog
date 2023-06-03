import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/datasources/product_datasources.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  final ProductDatasources productDatasources;
  DeleteProductBloc(
    this.productDatasources,
  ) : super(DeleteProductInitial()) {
    on<DoDeleteProductEvent>((event, emit) {
      emit(DeleteProductLoading());
      productDatasources.deleteProduct(event.id);
      emit(DeleteProductLoaded(id: event.id));
    });
  }
}
