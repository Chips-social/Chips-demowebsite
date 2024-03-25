import 'package:chips_demowebsite/pages/category_tab.dart';
import 'package:chips_demowebsite/pages/home.dart';
import 'package:chips_demowebsite/pages/mainpage.dart';
import 'package:chips_demowebsite/pages/my_curation_chips.dart';
import 'package:chips_demowebsite/pages/my_curations.dart';
import 'package:chips_demowebsite/pages/page404.dart';
import 'package:chips_demowebsite/pages/saved_curation_chips.dart';
import 'package:chips_demowebsite/pages/saved_curations.dart';
import 'package:chips_demowebsite/widgets/chip_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class AppRoutes {
//   static const String routee = '/';
//   // static const String routesubdom = '/business';
//   static const String homeRoute = '/category/:categoryName';
//   static const String curationRoute =
//       '/category/:categoryName/curation/:title/id/:id';
//   static const String mycurationRoute = '/mycuration/:title';
//   static const String savedCurationRoute = '/savedcuration/saved';
//   static const String pageNotFoundRoute = '/page-not-found';
//   static const String myCurationChipsRoute = '/curationchips/:chip/id/:id';
//   static const String savedCurationChipsRoute = '/savedchips/:chip/id/:id';
//   // static const String categoryRoute = '/category/:categoryName';

//   static final List<GetPage> routes = [
//     // GetPage(
//     //   name: routesubdom,
//     //   page: () => const HomeMainPage(child: BusinessHomeCuration()),
//     // ),
//     GetPage(
//       name: routee,
//       page: () => const MainPage(child: CategoryTab(child: Home())),
//     ),
//     GetPage(
//       name: homeRoute,
//       page: () => const MainPage(child: CategoryTab(child: Home())),
//     ),
//     GetPage(
//       name: curationRoute,
//       page: () => const MainPage(child: CategoryTab(child: ChipDemo())),
//     ),
//     GetPage(
//       name: mycurationRoute,
//       page: () => const MainPage(child: MyCurations()),
//     ),
//     GetPage(
//       name: savedCurationRoute,
//       page: () => const MainPage(child: SavedCurations()),
//     ),
//     GetPage(
//       name: pageNotFoundRoute,
//       page: () => const Page404(),
//     ),

//     GetPage(
//       name: myCurationChipsRoute,
//       page: () => const MainPage(child: MyCurationChips()),
//     ),
//     GetPage(
//       name: savedCurationChipsRoute,
//       page: () => const MainPage(child: SavedCurationChips()),
//     ),
//     // Fallback for undefined routes
//   ];
// }

// final GoRouter router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) =>
//           const MainPage(child: CategoryTab(categoryName: "", child: Home())),
//     ),
//     GoRoute(
//       path: '/category/:categoryName',
//       builder: (BuildContext context, GoRouterState state) {
//         final categoryName = state.pathParameters['categoryName'] ?? "";
//         return MainPage(
//             child:
//                 CategoryTab(categoryName: categoryName, child: const Home()));
//       },
//     ),
//     GoRoute(
//       path: '/category/:categoryName/curation/:title/id/:id',
//       builder: (BuildContext context, GoRouterState state) {
//         final categoryName = state.pathParameters['categoryName'] ?? "";
//         final title = state.pathParameters['title'] ?? "";
//         final id = state.pathParameters['id'] ?? "";

//         return MainPage(
//             child: CategoryTab(
//                 categoryName: categoryName,
//                 child: ChipDemo(title: title, curId: id)));
//       },
//     ),
//     GoRoute(
//       path: '/mycuration/:title',
//       builder: (BuildContext context, GoRouterState state) {
//         final title = state.pathParameters['title'] ?? "";
//         return MainPage(child: MyCurations(title: title));
//       },
//     ),
//     GoRoute(
//       path: '/savedcuration/saved',
//       builder: (BuildContext context, GoRouterState state) {
//         return const MainPage(child: SavedCurations());
//       },
//     ),
//     GoRoute(
//       path: '/curationchips/:chip/id/:id',
//       builder: (BuildContext context, GoRouterState state) {
//         final title = state.pathParameters['chip'] ?? "";
//         final curId = state.pathParameters['id'] ?? "";
//         return MainPage(child: MyCurationChips(title: title, curId: curId));
//       },
//     ),
//     GoRoute(
//       path: '/savedchips/:chip/id/:id',
//       builder: (BuildContext context, GoRouterState state) {
//         final title = state.pathParameters['chip'] ?? "";
//         final curId = state.pathParameters['id'] ?? "";
//         return MainPage(child: SavedCurationChips(title: title, curId: curId));
//       },
//     ),
//   ],
//   errorBuilder: (context, state) => const Page404(),
// );

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainPage(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const CategoryTab(categoryName: "", child: Home()),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
          ),
        ),
        GoRoute(
          path: '/category/:categoryName',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final categoryName = state.pathParameters['categoryName'] ?? "";
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child:
                  CategoryTab(categoryName: categoryName, child: const Home()),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // No animation: child is returned directly
                return child;
              },
            );
          },
        ),
        GoRoute(
          path: '/category/:categoryName/curation/:title/id/:id',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final categoryName = state.pathParameters['categoryName'] ?? "";
            final title = state.pathParameters['title'] ?? "";
            final id = state.pathParameters['id'] ?? "";
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: CategoryTab(
                  categoryName: categoryName,
                  child: ChipDemo(title: title, curId: id)),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),
        GoRoute(
          path: '/mycuration/MyCurations',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const MyCurations(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
          ),
        ),
        GoRoute(
          path: '/savedcuration/saved',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const SavedCurations(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
          ),
        ),
        GoRoute(
          path: '/curationchips/:chip/id/:id',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final title = state.pathParameters['chip'] ?? "";
            final curId = state.pathParameters['id'] ?? "";
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: MyCurationChips(title: title, curId: curId),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),
        GoRoute(
          path: '/savedchips/:chip/id/:id',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final title = state.pathParameters['chip'] ?? "";
            final curId = state.pathParameters['id'] ?? "";
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: SavedCurationChips(title: title, curId: curId),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const Page404(),
);
