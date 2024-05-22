import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:master_bloc/features/cart/ui/cart_tile_widget.dart';
import 'package:master_bloc/features/home/ui/product_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart Items'),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          bloc: cartBloc,
          listenWhen: (CartState previous, CartState current) => current is CartActionState,
          buildWhen: (CartState previous, CartState current) => current is! CartActionState,
          listener: (BuildContext context, CartState state) {},
          builder: (BuildContext context, CartState state) {
            switch (state.runtimeType) {
              case CartSuccessState:
                final CartSuccessState successState = state as CartSuccessState;
                return ListView.builder(
                    itemCount: successState.cartItems.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return CartTileWidget(
                        cartBloc: cartBloc,
                        productDataModel: successState.cartItems[index],
                      );
                    }));
              case CartIsEmptyState:
                return const Center(
                  child: Text("You don't have any items in the cart..."),
                );
              default:
            }
            return Container();
          },
        ));
  }
}
