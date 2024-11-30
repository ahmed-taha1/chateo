import 'package:chateo/core/routing/routes.dart';
import 'package:chateo/features/home/logic/home_cubit.dart';
import 'package:chateo/features/home/ui/home_view.dart';
import 'package:chateo/features/login/ui/login_view.dart';
import 'package:chateo/features/on_boarding/on_boarding_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboardingView.path,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: Routes.loginView.path,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: Routes.homeView.path,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomeView(),
        ),
      ),
    ],
  );
}
