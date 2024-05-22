part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishListButtonClickedEvent extends HomeEvent {
  HomeProductWishListButtonClickedEvent({required this.clickedProduct});

  final ProductDataModel clickedProduct;
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  HomeProductCartButtonClickedEvent({required this.clickedProduct});

  final ProductDataModel clickedProduct;
}

class HomeWishListButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
