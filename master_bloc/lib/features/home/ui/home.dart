import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_bloc/features/cart/ui/cart.dart';
import 'package:master_bloc/features/home/bloc/home_bloc.dart';
import 'package:master_bloc/features/home/ui/product_tile_widget.dart';
import 'package:master_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (HomeState previous, HomeState current) => current is HomeActionState,
      buildWhen: (HomeState previous, HomeState current) => current is! HomeActionState,
      listener: (BuildContext context, HomeState state) {
        if (state is HomeNavigateToCartPageActionState) {
          print('Button Clicked');
          Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => const Cart()));
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => const WishList()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item Carted')));
        } else if (state is HomeProductItemWishListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item Wish Listed')));
        }
      },
      builder: (BuildContext context, HomeState state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final HomeLoadedSuccessState successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Grocery App'),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishListButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: ((BuildContext context, int index) {
                    return ProductTileWidget(
                      homeBloc: homeBloc,
                      productDataModel: successState.products[index],
                    );
                  })),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error...'),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text("Something Happened that we don't know."),
              ),
            );
        }
      },
    );
  }
}
