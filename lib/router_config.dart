import 'package:go_router/go_router.dart';
import 'package:systemforschool/screens/login_screen.dart';
import 'package:systemforschool/screens/scaffold_with_bottom_navbar.dart';
import 'package:systemforschool/screens/chat_screen.dart';
import 'package:systemforschool/screens/details_screen.dart';
import 'package:systemforschool/screens/home_screen.dart';

final goRouter = GoRouter(
    initialLocation: '/a',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
              path: '/a',
              pageBuilder: (context, state) => NoTransitionPage(
                  child: HomeScreen(label: 'A',),
              ),
          routes: [
            GoRoute(
              path: 'details',
              builder: (context, state) => DetailsScreen(label: 'A'),
            ),
          ],
          ),
          GoRoute(
              path: '/b',
              pageBuilder: (context, state) => NoTransitionPage(child: HomeScreen(label: 'B',),
              ),
            routes: [
              GoRoute(
                  path: 'details',
                  builder: (context, state) => DetailsScreen(label: 'B'),
              ),
            ],
          ),
          GoRoute(
              path: '/c',
              pageBuilder: (context, state) => NoTransitionPage(
                child: ChatScreen(label: 'C'),
              ),
          routes: [
            GoRoute(
                path: 'details',
                builder: (context, state) => DetailsScreen(label: 'C'),
            ),
          ],
          ),
        ]
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => NoTransitionPage(
          child: LoginScreen(),
        ),

      ),
    ]
);