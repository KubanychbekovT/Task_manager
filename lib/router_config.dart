import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:systemforschool/screens/add_projects_screen.dart';
import 'package:systemforschool/screens/login_screen.dart';
import 'package:systemforschool/screens/scaffold_with_bottom_navbar.dart';
import 'package:systemforschool/screens/chat_screen.dart';
import 'package:systemforschool/screens/details_screen.dart';
import 'package:systemforschool/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
//EmailLinkAuthProvider(actionCodeSettings: ActionCodeSettings(url: "com.app/verify?uid="+"ff"))
final goRouter = GoRouter(

    initialLocation: '/a',
    routes: [
      GoRoute(path: '/sign-in',
          builder: (context,state){
            return SignInScreen(providers: [EmailAuthProvider()],actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                context.go('/a');
              }),
            ]);
          }),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            redirect: (context,state){
              if(FirebaseAuth.instance.currentUser == null){
                return '/sign-in';
              }else{
                return '/a';
              }
            },
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
              pageBuilder: (context, state) => NoTransitionPage(child: AddProjectsScreen(),
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