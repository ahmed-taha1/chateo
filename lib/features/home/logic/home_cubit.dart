import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  TextEditingController searchController = TextEditingController();
  int currHomeNavBarIndex = 0;
  HomeCubit() : super(HomeInitial());

  void changePageIndex(int index) {
    currHomeNavBarIndex = index;
    emit(HomeChangeIndex(index));
  }
}