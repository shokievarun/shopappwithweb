part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveEvent extends CartEvent {
  final ProductDataModel productDataModel;

  CartRemoveEvent({required this.productDataModel});
}
