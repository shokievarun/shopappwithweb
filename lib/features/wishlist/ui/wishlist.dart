import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappbloc/features/home/bloc/home_bloc.dart';
import 'package:shopappbloc/features/home/ui/product_tile.dart';
import 'package:shopappbloc/features/wishlist/bloc/wishlist_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({required this.homeBloc});
  final HomeBloc homeBloc;
  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Wishlist Items")),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listener: (context, state) {
            if (state.runtimeType == WishlistRemoveActionState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Item Removed')));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case WishlistSuccessState:
                final successState = state as WishlistSuccessState;
                return ListView.builder(
                    itemCount: successState.productDataModel.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                        productDataModel: successState.productDataModel[index],
                        wishListBloc: wishlistBloc,
                        homeBloc: widget.homeBloc,
                      );
                    });
            }
            return const Placeholder();
          },
        ));
  }
}
