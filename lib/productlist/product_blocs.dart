/*
*    @author     KGPARMAR
*    @project    online_shopping
*    @file_name  app_blocs
*    @desc       Flutter Developer
*    @version    1.0.0
*    @since      1.0
*    @created on 05-Apr-23 9:24 PM
*    @updated on 05-Apr-23 9:24 PM
*    @Notes       
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/productlist/product_events.dart';
import 'package:online_shopping/productlist/product_states.dart';
import 'package:online_shopping/repo/user_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _productRepository.getProducts(page: event.page!);
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
