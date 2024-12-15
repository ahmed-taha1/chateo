import 'package:chateo/core/models/community.dart';
import 'package:chateo/features/home/data/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  final HomeRepo homeRepo;
  TextEditingController searchController = TextEditingController();
  int currHomeNavBarIndex = 0;
  late String phoneNumber;
  late List<Community> communities;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  void changePageIndex(int index) {
    currHomeNavBarIndex = index;
    emit(HomeChangeIndex(index));
  }

  void fetchData() async {
    emit(HomeLoading());
    phoneNumber = await homeRepo.getPhoneNumberFromCache();
    communities = await homeRepo.fetchCommunities(phoneNumber: phoneNumber);
    emit(HomeLoaded());
  }
}