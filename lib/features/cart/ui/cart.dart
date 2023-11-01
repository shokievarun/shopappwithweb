import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappbloc/data/grocery_data.dart';
import 'package:shopappbloc/features/cart/bloc/cart_bloc.dart';
import 'package:shopappbloc/features/home/bloc/home_bloc.dart';
import 'package:shopappbloc/features/home/ui/product_tile.dart';

class Cart extends StatefulWidget {
  const Cart({required this.homeBloc});
  final HomeBloc homeBloc;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Cart Items")),
        body: BlocConsumer<CartBloc, CartState>(
          bloc: cartBloc,
          listener: (context, state) {
            if (state.runtimeType == CartItemRemovedActionState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Item Removed')));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartSuccessState:
                final successState = state as CartSuccessState;
                return ListView.builder(
                    itemCount: successState.cartItems.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                        productDataModel: successState.cartItems[index],
                        cartBloc: cartBloc,
                        homeBloc: widget.homeBloc,
                      );
                    });
            }
            return const Placeholder();
          },
        ));
  }
}
