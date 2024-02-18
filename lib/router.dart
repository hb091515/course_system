import 'package:course_system/app/course_app.dart';
import 'package:course_system/page/courselist/course_list_page.dart';
import 'package:course_system/style/my_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CourseApp(),
      routes: [
        GoRoute(
          path: 'course_list',
          pageBuilder: (context, state) => buildMyTranstion<void>(
              key: const ValueKey('courseList'),
              child: const CourseListPage(),
              color: Colors.white),
          // routes: [
          //   GoRoute(
          //     path: 'course_detail',
          //     redirect: (context, state) {
          //       if (state.extra == null) {
          //         return '/';
          //       }

          //       return null;
          //     },
          //     pageBuilder: (context, state) {
          //       final map = state.extra! as Map<String, dynamic>;
          //       // final
          //     },
          //   ),
          // ],
        ),
      ],
    ),
  ],
);
