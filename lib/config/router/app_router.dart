import 'package:cine_tfg_app/config/router/app_router_notifier.dart';
import 'package:cine_tfg_app/features/auth/auth.dart';
import 'package:cine_tfg_app/features/auth/presentation/providers/providers.dart';
import 'package:cine_tfg_app/presentation/screens/movies/tv_screen.dart';
import 'package:cine_tfg_app/presentation/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);



  return GoRouter(
  //initialLocation: '/home/0',
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [

      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = int.parse( state.pathParameters['page'] ?? '0' );

          return HomeScreen( pageIndex: pageIndex );
        },
        routes: [
           GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';

              return MovieScreen( movieId: movieId );
            },
          ),
          GoRoute(
            path: 'tv/:id',
            name: TvScreen.name,
            builder: (context, state) {
              final tvId = state.pathParameters['id'] ?? 'no-id';

              return TvScreen( tvId: tvId );
            },
          ),
        ]
      ),
      GoRoute(
        path: '/',
        redirect: ( _ , __ ) => '/home/0',
      ),

    ],

    redirect: (context, state) {
       if (!state.matchedLocation.startsWith('/home')) {
        return '/home/0'; // Siempre redirigir a '/home/0' u otra página si lo prefieres
      }

      // Si ya está en una página de '/home', no redirigir
      return null;
      
    },


  );
});
