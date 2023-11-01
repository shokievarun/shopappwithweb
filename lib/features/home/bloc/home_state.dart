part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeFavoriteLikeState extends HomeState {}

class HomeFavoriteUnlikeState extends HomeState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductItemCartedActionState extends HomeActionState {}

class HomeProductItemWishlistedActionState extends HomeActionState {}

class HomeNavigateToFavouritePageActionState extends HomeActionState {}

class HomeProductItemWishlistedRemovedActionState extends HomeActionState {}

class HomeProductItemCartedRemovedActionState extends HomeActionState {}
