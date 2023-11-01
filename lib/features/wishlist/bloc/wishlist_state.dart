part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistRemoveActionState extends WishlistActionState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> productDataModel;

  WishlistSuccessState({required this.productDataModel});
}
