import 'package:ChatPaLM/Routes/app_route_constants.dart';
import 'package:ChatPaLM/screens/auth_page.dart';
import 'package:ChatPaLM/screens/home_page.dart';
import 'package:ChatPaLM/screens/profile.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter {
  GoRouter router = GoRouter(routes: [
    GoRoute(
      name: MyAppRoutConstants.authRoute,
      path: '/',
      builder: (context, state) {
        return const AuthPage();
      },
    ),
    GoRoute(
      name: MyAppRoutConstants.hompageRoute,
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: MyAppRoutConstants.profileRoute,
      path: '/profile',
      builder: (context, state) {
        return const Profile();
      },
    ),
  ]);
}
