part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeChangeIndex extends HomeState {
  final int index;
  const HomeChangeIndex(this.index);
  @override
  List<Object> get props => [index];
}

class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {}

class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
  @override
  List<Object> get props => [message];
}