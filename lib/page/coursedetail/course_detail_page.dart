import 'package:flutter/material.dart';

import '../../entities/get_lecturer_info.dart';
import '../../utils/image_usecase.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage(
      {super.key, required this.course, required this.lecturer});

  final Courses course;
  final Lecturer lecturer;

  @override
  State<StatefulWidget> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final lecturer = widget.lecturer;
    return Scaffold(
        appBar: AppBar(title: Text("${course.title}")),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: const BoxDecoration(
                  color: Color(0xffDCDCDC),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ImageUsecase().imageFromBase64String(lecturer.image),
                        _gap,
                        SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            thickness: 0.5,
                            width: 10,
                            color: Colors.black,
                          ),
                        ),
                        _gap,
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "授課教師：${lecturer.name}",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                "職稱：${lecturer.position}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(4)),
                    Divider(
                      thickness: 2,
                    ),
                    _gap,
                    Text("課程簡介"),
                    _gap,
                    Text("課程名稱：${course.title}"),
                    Text("上課時間：${course.date}"),
                    Text("課程難度：${course.level}"),
                    Text("課程描述：${course.description}"),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  static const _gap = SizedBox(width: 16, height: 16);
}
