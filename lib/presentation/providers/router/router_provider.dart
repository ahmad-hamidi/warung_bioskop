import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/pages/login_page/login_page.dart';
import 'package:warung_bioskop/presentation/pages/main_page/main_page.dart';
import 'package:warung_bioskop/presentation/pages/register_page/register_page.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/${RouterName.main}',
          name: RouterName.main,
          builder: (context, state) => const MainPage(),
        ),
        GoRoute(
          path: '/${RouterName.login}',
          name: RouterName.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/${RouterName.register}',
          name: RouterName.register,
          builder: (context, state) => const RegsiterPage(),
        ),
      ],
      initialLocation: '/${RouterName.login}',
      debugLogDiagnostics: true,
    );
