part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeChangeIndex extends HomeState {
  final int index;
  const HomeChangeIndex(this.index);
  @override
  List<Object> get props => [index];
}