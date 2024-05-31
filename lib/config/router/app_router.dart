import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/config/router/app_router_notifier.dart';
import 'package:tasks_app/presentation/providers/auth_provider.dart';
import 'package:tasks_app/presentation/screens/chat_screen.dart';
import 'package:tasks_app/presentation/screens/check_auth_status_screen.dart';
import 'package:tasks_app/presentation/screens/home_screen.dart';
import 'package:tasks_app/presentation/screens/login_screen.dart';
import 'package:tasks_app/presentation/screens/perfil_screen.dart';
import 'package:tasks_app/presentation/screens/task_screen.dart';


final goRouterProvider = Provider((ref) {
  
  final goRouterNotifier = ref.read(goRouterNotifierProvider);


return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      ///* tasks Routes
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
        path: '/task/:id', 
        builder: (context, state) => TaskScreen(
          taskId: state.pathParameters['id'] ?? 'no-id',
        ),
      ),
    
    ///* chats Routes
    GoRoute(
        path: '/chat/:id', 
        builder: (context, state) => ChatScreen(
          chatId: state.pathParameters['id'] ?? 'no-id',
        ),
      ),
    ],

    redirect: (context, state) {
      
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' ) return null;

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login'  || isGoingTo == '/splash' ){
           return '/home/0';
        }
      }


      return null;
    },
  );
});