import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic4_flutter_auth/data/models/request/product_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:fic4_flutter_auth/data/datasources/product_datasources.dart';
import 'package:fic4_flutter_auth/data/models/response/product_response_model.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductDatasources productDatasources;
  UpdateProductBloc(
    this.productDatasources,
  ) : super(UpdateProductInitial()) {
    on<DoUpdateProductEvent>((event, emit) async {
      emit(UpdateProductLoading());
      final result =
          await productDatasources.updateProduct(event.productModel, event.id);
      emit(UpdateProductLoaded(productResponseModel: result, id: event.id));
    });
  }
}
