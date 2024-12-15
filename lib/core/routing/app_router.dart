import 'package:chateo/core/di/get_it.dart';
import 'package:chateo/core/routing/routes.dart';
import 'package:chateo/features/authentication/logic/authentication_cubit.dart';
import 'package:chateo/features/authentication/ui/add_phone_number_view.dart';
import 'package:chateo/features/authentication/ui/login_with_phone_number.dart';
import 'package:chateo/features/authentication/ui/register_view.dart';
import 'package:chateo/features/chat/logic/chat_bloc.dart';
import 'package:chateo/features/chat/logic/chat_event.dart';
import 'package:chateo/features/home/logic/home_cubit.dart';
import 'package:chateo/features/home/ui/home_view.dart';
import 'package:chateo/features/on_boarding/on_boarding_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/ui/login_view.dart';
import '../../features/chat/ui/chat_view.dart';
import '../services/cache_service.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboardingView.path,
        builder: (context, state) => const OnBoardingView(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => AuthenticationCubit(getIt()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: Routes.loginView.path,
            builder: (context, state) => const LoginView(),
          ),
          GoRoute(
            path: Routes.registerView.path,
            builder: (context, state) => const RegisterView(),
          ),
          GoRoute(
            path: Routes.addNumberView.path,
            builder: (context, state) {
              return const AddPhoneNumberView();
            },
          ),
          GoRoute(
            path: Routes.loginWithPhoneNumber.path,
            builder: (context, state) {
              return const LoginWithPhoneNumber();
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.homeView.path,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(getIt())..fetchData(),
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: Routes.chatView.path,
        builder: (context, state) => BlocProvider(
          create: (context) => ChatBloc(
              (state.extra as Map<String, dynamic>)["phoneNumber"] as String,
              getIt())
            ..add(FetchChat(
                (state.extra as Map<String, dynamic>)["chatId"] as String)),
          child: ChatView(
              chatId:
                  (state.extra as Map<String, dynamic>)["chatId"] as String),
        ),
      ),
    ],
    initialLocation: Routes.onboardingView.path,
  );

  static Future<void> setInitialRoute() async {
    if (await CacheService.getData(key: CacheServiceConstants.isLogged) ==
            true &&
        await CacheService.getData(key: CacheServiceConstants.phoneNumber) !=
            null) {
      router.go(
        Routes.homeView.path,
      );
    }
  }
}
