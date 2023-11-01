import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappbloc/constants/enums.dart';
import 'package:shopappbloc/data/cart_items.dart';
import 'package:shopappbloc/features/cart/ui/cart.dart';
import 'package:shopappbloc/features/home/bloc/home_bloc.dart';
import 'package:shopappbloc/features/home/ui/product_tile.dart';
import 'package:shopappbloc/features/internet_bloc/internet_bloc.dart';
import 'package:shopappbloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Cart(
                        homeBloc: homeBloc,
                      ))).then((value) => homeBloc.add(HomeRebuildEvent()));
        } else if (state is HomeNavigateToFavouritePageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Wishlist(
                        homeBloc: homeBloc,
                      ))).then((value) => homeBloc.add(HomeRebuildEvent()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Carted')));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Wishlisted ')));
        } else if (state is HomeProductItemCartedRemovedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item Carted Removed')));
        } else if (state is HomeProductItemWishlistedRemovedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item Wishlisted Removed')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));

          case HomeLoadedSuccessState:
            final succesState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Grocery App"),
                actions: [
                  // IconButton(
                  //   onPressed: () {
                  //     // homeBloc.add(HomeFavouritesNavigateEvent());
                  //     homeBloc.add(HomeFavoriteEvent());
                  //     //  context.read<HomeBloc>().add(HomeRebuildEvent());
                  //     // BlocProvider.of<HomeBloc>(context)
                  //     //     .add(HomeRebuildEvent());
                  //     // context.watch<HomeBloc>().add(HomeRebuildEvent());
                  //     // context
                  //     //     .select((HomeBloc homeBloc) => homeBloc.productDatas);
                  //   },
                  //   icon: isFavorite
                  //       ? const Icon(Icons.favorite)
                  //       : const Icon(Icons.favorite_outline),
                  // ),
                  IconButton(
                    onPressed: () {
                      // homeBloc.add(HomeFavouritesNavigateEvent());
                      homeBloc.add(HomeFavoriteEvent());
                      //  context.read<HomeBloc>().add(HomeRebuildEvent());
                      // BlocProvider.of<HomeBloc>(context)
                      //     .add(HomeRebuildEvent());
                      // context.watch<HomeBloc>().add(HomeRebuildEvent());
                      // context
                      //     .select((HomeBloc homeBloc) => homeBloc.productDatas);
                    },
                    icon: isFavorite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_outline),
                  ),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag))
                ],
              ),
              body: Column(
                children: [
                  BlocBuilder<InternetBloc, InternetState>(
                    builder: (context, state) {
                      if (state is InternetConnected &&
                          state.connectionType == ConnectionType.Wifi) {
                        return const SizedBox();
                        // Text(
                        //   'Wi-Fi',
                        //   style:
                        //       Theme.of(context).textTheme.headline3!.copyWith(
                        //             color: Colors.green,
                        //           ),
                        // );
                      } else if (state is InternetConnected &&
                          state.connectionType == ConnectionType.Mobile) {
                        return const SizedBox();
                        // Text(
                        //   'Mobile',
                        //   style:
                        //       Theme.of(context).textTheme.headline3!.copyWith(
                        //             color: Colors.red,
                        //           ),
                        // );
                      } else if (state is InternetDisconnected) {
                        return Container(
                          color: Colors.red,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: const Text(
                            'Could not connect to internet',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        );
                      }
                      return Text(
                        'Check Connectivity',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.grey,
                            ),
                      );
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: succesState.products.length,
                        itemBuilder: (context, index) {
                          return ProductTileWidget(
                              productDataModel: succesState.products[index],
                              homeBloc: homeBloc);
                        }),
                  ),
                ],
              ),
            );
          case HomeErrorState:
            const Scaffold(
              body: Text("Something went wrong"),
            );
          default:
            return const SizedBox();
        }
        return const SizedBox();
      },
    );
  }
}
