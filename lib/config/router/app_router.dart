import 'package:go_router/go_router.dart';
import 'package:tasks_app/presentation/screens/home_screen.dart';
import 'package:tasks_app/presentation/screens/perfil_screen.dart';



final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse( state.pathParameters['page'] ?? '0' );

        return HomeScreen( pageIndex: pageIndex );
      },
      routes: [
         GoRoute(
          path: 'perfil',
          name: PerfilScreen.name,
          builder: (context, state) {
            return const PerfilScreen();
          },
        ),
      ]
    ),



    GoRoute(
      path: '/',
      redirect: ( _ , __ ) => '/home/0',
    ),

  ]
);