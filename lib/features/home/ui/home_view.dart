import 'package:chateo/core/widgets/custom_button.dart';
import 'package:chateo/features/chats/ui/chats_view.dart';
import 'package:chateo/features/communities/logic/communities_cubit.dart';
import 'package:chateo/features/communities/ui/communities_view.dart';
import 'package:chateo/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/get_it.dart';
import '../../../core/routing/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeChangeIndex && state.index == 1) {
            return BlocProvider(
              create: (context) => CommunitiesCubit(
                communities: context.read<HomeCubit>().communities,
                phoneNumber: context.read<HomeCubit>().phoneNumber,
                communitiesRepo: getIt()
              ),
              child: const CommunitiesView(),
            );
          } else if (state is HomeChangeIndex && state.index == 3) {
            return Center(
              child: CustomButton(
                text: "Logout",
                onPressed: () => context.go(Routes.loginView.path),
              ),
            );
          } else {
            return const ChatsView();
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const SizedBox();
            } else {
              return BottomNavigationBar(
                elevation: 2,
                type: BottomNavigationBarType.fixed,
                enableFeedback: false,
                backgroundColor: const Color(0xFFFFFFFF),
                showUnselectedLabels: true,
                unselectedItemColor: const Color(0xFFC6CFDC),
                selectedItemColor: Theme.of(context).primaryColorLight,
                currentIndex: context.read<HomeCubit>().currHomeNavBarIndex,
                onTap: (index) {
                  context.read<HomeCubit>().changePageIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Icon(
                        Icons.person_rounded,
                        size: 29,
                      ),
                    ),
                    label: 'Chats',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: Icon(
                        Icons.groups_rounded,
                        size: 29,
                      ),
                    ),
                    label: 'Communities',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: Icon(
                        Icons.search_rounded,
                        size: 29,
                      ),
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: Icon(
                        Icons.settings_rounded,
                        size: 29,
                      ),
                    ),
                    label: 'Settings',
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
