import 'package:flutter/material.dart';

import '../page/courselist/course_list_page.dart';

class CourseApp extends StatefulWidget {
  const CourseApp({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CourseAppState();
}

class _CourseAppState extends State<CourseApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("課程選擇"),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text("進入課程清單"),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CourseListPage(),
            ),
          );
        },
      )),
    );
  }
}
