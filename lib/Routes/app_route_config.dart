import 'package:ChatPaLM/Routes/app_route_constants.dart';
import 'package:ChatPaLM/screens/Authentication/auth_page.dart';
import 'package:ChatPaLM/screens/Home/home_page.dart';
import 'package:ChatPaLM/screens/Profile/profile.dart';
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
