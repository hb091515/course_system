import 'package:course_system/entities/get_lecturer_info.dart';
import 'package:course_system/page/coursedetail/course_detail_page.dart';
import 'package:course_system/utils/image_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../usecase/get_lecturer_usecase.dart';
import '../../utils/custom_expansiontile.dart' as custom;

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});
  @override
  State<StatefulWidget> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  late CourseListBloc bloc;

  @override
  void initState() {
    bloc = CourseListBloc(CourseListState(status: CourseListStatus.init));
    bloc.add(Init());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("講師清單")),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocBuilder<CourseListBloc, CourseListState>(
          builder: (context, state) {
            final lecturerInfo = state.getLecturerInfo;

            if (state.status == CourseListStatus.success) {
              return Center(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  itemBuilder: (context, index) {
                    final courseList =
                        lecturerInfo?.data[index].courseData ?? [];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: custom.ExpansionTile(
                        shape: const Border(),
                        tilePadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        leading: ImageUsecase().imageFromBase64String(
                            lecturerInfo?.data[index].image ?? ""),
                        onExpansionChanged: (bool expanded) async {},
                        title: Text(
                          "${lecturerInfo?.data[index].position}",
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        subtitle: Text(
                          "${lecturerInfo?.data[index].name}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                        children: [
                          const Divider(
                            indent: 16,
                            endIndent: 16,
                          ), // 在標題和內容之間添加分隔線
                          ...courseList.map((course) {
                            return ListTile(
                              contentPadding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                              leading: Icon(Icons.calendar_month_outlined),
                              trailing: Icon(Icons.chevron_right),
                              title: Text("${course.title}"),
                              subtitle: Text("${course.date}"),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CourseDetailPage(
                                      course: course,
                                      lecturer: lecturerInfo!.data[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                  itemCount: lecturerInfo?.data.length,
                ),
              );
            } else if (state.status == CourseListStatus.loading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return const Center(
                child: Text("資料獲取失敗"),
              );
            }
          },
        ),
      ),
    );
  }
}

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc(initialState) : super(initialState) {
    on<Init>(init);
  }

  Future<void> init(Init event, Emitter<CourseListState> emit) async {
    emit.call(state.copyWith(status: CourseListStatus.loading));

    try {
      GetLecturerInfo getLecturerInfo = await GetLecturerUsecase().call();
      emit.call(state.copyWith(
        status: CourseListStatus.success,
        getLecturerInfo: getLecturerInfo,
      ));
    } catch (err) {
      emit.call(state.copyWith(status: CourseListStatus.fail));
    }
  }
}

class CourseListState extends Equatable {
  final CourseListStatus status;

  final GetLecturerInfo? getLecturerInfo;

  const CourseListState({
    required this.status,
    this.getLecturerInfo,
  });

  CourseListState copyWith({
    CourseListStatus? status,
    GetLecturerInfo? getLecturerInfo,
  }) =>
      CourseListState._(
        status: status ?? this.status,
        getLecturerInfo: getLecturerInfo ?? this.getLecturerInfo,
      );

  const CourseListState._({
    required this.status,
    this.getLecturerInfo,
  });

  @override
  List<Object?> get props => [status, getLecturerInfo];
}

abstract class CourseListEvent {}

class Init extends CourseListEvent {}

enum CourseListStatus {
  init,
  loading,
  success,
  fail,
}
