import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappbloc/data/cart_items.dart';
import 'package:shopappbloc/data/wishlist_items.dart';
import 'package:shopappbloc/features/cart/bloc/cart_bloc.dart';
import 'package:shopappbloc/features/home/bloc/home_bloc.dart';
import 'package:shopappbloc/features/home/model/home_product_data_model.dart';
import 'package:shopappbloc/features/wishlist/bloc/wishlist_bloc.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  HomeBloc? homeBloc;

  CartBloc? cartBloc;
  WishlistBloc? wishListBloc;
  ProductTileWidget(
      {super.key,
      required this.productDataModel,
      this.homeBloc,
      this.cartBloc,
      this.wishListBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(productDataModel.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${productDataModel.price}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (homeBloc != null) {
                          homeBloc!.add(HomeFavouritesClickEvent(
                              productDataModel: productDataModel));
                        } else if (wishListBloc != null) {
                          wishListBloc!.add(WishlistRemoveEvent(
                              productDataModel: productDataModel));
                        }
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: wishlistItems.any(
                                (element) => element.id == productDataModel.id)
                            ? Colors.red
                            : null,
                      )),
                  IconButton(
                      onPressed: () async {
                        if (homeBloc != null) {
                          homeBloc!.add(HomeCartClickEvent(
                              productDataModel: productDataModel));
                        } else if (cartBloc != null) {
                          cartBloc!.add(CartRemoveEvent(
                              productDataModel: productDataModel));
                        }
                      },
                      icon: Icon(homeBloc != null
                          ? cartItems.any((element) =>
                                  element.id == productDataModel.id)
                              ? Icons.shopping_bag
                              : Icons.shopping_bag_outlined
                          : Icons.shopping_bag)),
                  Container(
                    decoration: BoxDecoration(
                      shape:
                          BoxShape.circle, // This makes the container circular
                      border: Border.all(color: Colors.black),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (homeBloc != null) {
                          homeBloc!.add(HomeProductRemoveEvent(
                              productDataModel: productDataModel));
                        }
                        if (cartBloc != null) {
                          cartBloc!.add(CartInitialEvent());
                        }

                        if (wishListBloc != null) {
                          wishListBloc!.add(WishlistInitialEvent());
                        }
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    !cartItems
                            .any((element) => element.id == productDataModel.id)
                        ? "0"
                        : cartItems
                            .firstWhere(
                                (element) => element.id == productDataModel.id)
                            .count
                            .toString(), // You can replace this with the actual quantity
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape:
                          BoxShape.circle, // This makes the container circular
                      border: Border.all(color: Colors.black),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (homeBloc != null) {
                          homeBloc!.add(HomeProductAddEvent(
                              productDataModel: productDataModel));
                          if (cartBloc != null) {
                            cartBloc!.add(CartInitialEvent());
                          }
                          if (wishListBloc != null) {
                            wishListBloc!.add(WishlistInitialEvent());
                          }
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
