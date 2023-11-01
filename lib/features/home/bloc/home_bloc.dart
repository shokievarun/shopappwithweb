import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopappbloc/data/cart_items.dart';
import 'package:shopappbloc/data/grocery_data.dart';
import 'package:shopappbloc/data/wishlist_items.dart';
import 'package:shopappbloc/features/home/model/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeRebuildEvent>(homeRebuildEvent);
    on<HomeCartNavigateEvent>(homeCartNavigateEvent);
    on<HomeFavouritesNavigateEvent>(homeFavouritesNavigateEvent);
    on<HomeCartClickEvent>(homeCartClickEvent);
    on<HomeFavouritesClickEvent>(homeFavouritesClickEvent);
    on<HomeProductAddEvent>(homeProductAddEvent);
    on<HomeProductRemoveEvent>(homeProductRemoveEvent);
    on<HomeFavoriteEvent>(homeFavoriteEvent);
  }

  late List<ProductDataModel> productDatas;
  Future<FutureOr<void>> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    GroceryData.productsdatamodels = GroceryData.groceryProducts
        .map((e) => ProductDataModel(
            id: e['id'],
            name: e['name'],
            description: e['description'],
            price: e['price'],
            imageUrl: e['imageUrl']))
        .toList();
    productDatas = GroceryData.productsdatamodels;
    emit(HomeLoadedSuccessState(products: GroceryData.productsdatamodels));
  }

  FutureOr<void> homeCartNavigateEvent(
      HomeCartNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeFavouritesNavigateEvent(
      HomeFavouritesNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFavouritePageActionState());
  }

  FutureOr<void> homeCartClickEvent(
      HomeCartClickEvent event, Emitter<HomeState> emit) {
    if (cartItems.any((element) => element.id == event.productDataModel.id)) {
      cartItems.remove(cartItems
          .firstWhere((element) => element.id == event.productDataModel.id));
      emit(HomeProductItemCartedRemovedActionState());
    } else {
      cartItems.add(event.productDataModel);
      emit(HomeProductItemCartedActionState());
    }
    emit(HomeLoadedSuccessState(products: GroceryData.productsdatamodels));
  }

  FutureOr<void> homeFavouritesClickEvent(
      HomeFavouritesClickEvent event, Emitter<HomeState> emit) {
    if (wishlistItems
        .any((element) => element.id == event.productDataModel.id)) {
      wishlistItems.remove(wishlistItems
          .firstWhere((element) => element.id == event.productDataModel.id));
      emit(HomeProductItemWishlistedRemovedActionState());
    } else {
      wishlistItems.add(event.productDataModel);
      emit(HomeProductItemWishlistedActionState());
    }
    emit(HomeLoadedSuccessState(products: GroceryData.productsdatamodels));
  }

  FutureOr<void> homeRebuildEvent(
      HomeRebuildEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadedSuccessState(products: GroceryData.productsdatamodels));
  }

  FutureOr<void> homeProductAddEvent(
      HomeProductAddEvent event, Emitter<HomeState> emit) {
    if (cartItems.any((element) => element.id == event.productDataModel.id)) {
    } else {
      cartItems.add(event.productDataModel);
    }

    int index = cartItems
        .indexWhere((element) => element.id == event.productDataModel.id);
    int count = cartItems[index].count + 1;
    cartItems[index] = cartItems[index].copyWith(count: count);

    emit(HomeLoadedSuccessState(products: GroceryData.productsdatamodels));
  }

  FutureOr<void> homeProductRemoveEvent(
      HomeProductRemoveEvent event, Emitter<HomeState> emit) {
    if (cartItems.any((element) => element.id == event.productDataModel.id)) {
    } else {
      cartItems.add(event.productDataModel);
    }
    int index = cartItems
        .indexWhere((element) => element.id == event.productDataModel.id);
    int count = cartItems[index].count - 1;
    if (count < 0) {
      count = 0;
    }

    cartItems[index] = cartItems[index].copyWith(count: count);
    if (count == 0 &&
        cartItems.any((element) => element.id == event.productDataModel.id)) {
      cartItems.remove(cartItems
          .firstWhere((element) => element.id == event.productDataModel.id));
    }
    emit(HomeLoadedSuccessState(products: GroceryData.productsdatamodels));
  }

  FutureOr<void> homeFavoriteEvent(
      HomeFavoriteEvent event, Emitter<HomeState> emit) {
    isFavorite = !isFavorite;

    emit(HomeLoadedSuccessState(products: productDatas));
  }
}
