part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeRebuildEvent extends HomeEvent {}

class HomeFavouritesClickEvent extends HomeEvent {
  final ProductDataModel productDataModel;
  HomeFavouritesClickEvent({required this.productDataModel});
}

class HomeFavouritesNavigateEvent extends HomeEvent {}

class HomeCartClickEvent extends HomeEvent {
  final ProductDataModel productDataModel;
  HomeCartClickEvent({required this.productDataModel});
}

class HomeCartNavigateEvent extends HomeEvent {}

class HomeProductAddEvent extends HomeEvent {
  final ProductDataModel productDataModel;
  HomeProductAddEvent({required this.productDataModel});
}

class HomeProductRemoveEvent extends HomeEvent {
  final ProductDataModel productDataModel;
  HomeProductRemoveEvent({required this.productDataModel});
}

class HomeFavoriteEvent extends HomeEvent {}
