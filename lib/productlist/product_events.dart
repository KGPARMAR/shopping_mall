/*
*    @author     KGPARMAR
*    @project    online_shopping
*    @file_name  app_events
*    @desc       Flutter Developer
*    @version    1.0.0
*    @since      1.0
*    @created on 05-Apr-23 9:24 PM
*    @updated on 05-Apr-23 9:24 PM
*    @Notes       
*/

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProductEvent extends ProductEvent {
  LoadProductEvent(this.page);
  int? page;
  @override
  List<Object?> get props => [page];
}
