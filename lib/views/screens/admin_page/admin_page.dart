import 'package:flutter/material.dart';
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/models/lesson_model.dart';
import 'package:settings_page/models/quiz_model.dart';
import 'package:settings_page/viewmodels/course_view_model.dart';
import 'package:settings_page/views/widgets/custom_drawer.dart';
import 'package:settings_page/views/widgets/custom_list_view_builder_container.dart';

class AdminPage extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const AdminPage({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<TextEditingController> _courseTextEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> _lessonTextEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> _quizTextEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final CourseViewModel _courseViewModel = CourseViewModel();
  bool isTextFieldEmpty = false;
  final List<Lesson> _lessons = [];
  final List<Quiz> _quiz = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin panel'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: [
            /// text fields for course info
            TextField(
              controller: _courseTextEditingControllers[0],
              decoration: const InputDecoration(
                hintText: 'course title',
              ),
            ),
            TextField(
              controller: _courseTextEditingControllers[1],
              decoration: const InputDecoration(
                hintText: 'course description',
              ),
            ),
            TextField(
              controller: _courseTextEditingControllers[2],
              decoration: const InputDecoration(
                hintText: 'course image url',
              ),
            ),
            TextField(
              controller: _courseTextEditingControllers[3],
              decoration: const InputDecoration(
                hintText: 'course price',
              ),
            ),
            Text(isTextFieldEmpty ? 'Fill all fields' : ''),

            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Add lesson'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// text fields for lesson info
                        TextField(
                          controller: _lessonTextEditingControllers[0],
                          decoration: const InputDecoration(
                            hintText: 'lesson title',
                          ),
                        ),
                        TextField(
                          controller: _lessonTextEditingControllers[1],
                          decoration: const InputDecoration(
                            hintText: 'lesson description',
                          ),
                        ),
                        TextField(
                          controller: _lessonTextEditingControllers[2],
                          decoration: const InputDecoration(
                            hintText: 'lesson video url',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      /// cancel button
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),

                      /// save lesson button
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _lessons.add(
                            Lesson(
                              lessonId: 1,
                              courseId: 1,
                              lessonTitle:
                                  _lessonTextEditingControllers[0].text,
                              lessonDescription:
                                  _lessonTextEditingControllers[1].text,
                              videoUrl: _lessonTextEditingControllers[2].text,
                              lessonQuiz: _quiz,
                            ),
                          );

                          for (TextEditingController each
                              in _lessonTextEditingControllers) {
                            each.clear();
                          }
                        },
                        child: const Text('Save'),
                      ),

                      /// button to add quiz
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Add quiz'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /// text fields for quiz info
                                  TextField(
                                    controller: _quizTextEditingControllers[0],
                                    decoration: const InputDecoration(
                                      hintText: 'quiz question',
                                    ),
                                  ),
                                  TextField(
                                    controller: _quizTextEditingControllers[1],
                                    decoration: const InputDecoration(
                                      hintText: 'options separate by coma (,)',
                                    ),
                                  ),
                                  TextField(
                                    controller: _quizTextEditingControllers[2],
                                    decoration: const InputDecoration(
                                      hintText: 'correct answer (index)',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                /// cancel button
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),

                                /// save quiz button
                                TextButton(
                                  onPressed: () {
                                    _quiz.add(
                                      Quiz(
                                        qCorrectAnswer: int.parse(
                                            _quizTextEditingControllers[2]
                                                .text),
                                        qId: DateTime.now().hashCode,
                                        qOptions: _quizTextEditingControllers[1]
                                            .text
                                            .split(','),
                                        qQuestion:
                                            _quizTextEditingControllers[0].text,
                                      ),
                                    );
                                    for (TextEditingController each
                                        in _quizTextEditingControllers) {
                                      each.clear();
                                    }

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('Add Quiz'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Add lesson'),
            ),

            /// adding course to database button
            TextButton(
              onPressed: () {
                isTextFieldEmpty = false;
                for (TextEditingController each
                    in _courseTextEditingControllers) {
                  if (each.text.trim().isEmpty) {
                    isTextFieldEmpty = true;
                    break;
                  }
                }
                if (!isTextFieldEmpty &&
                    _quiz.isNotEmpty &&
                    _lessons.isNotEmpty) {
                  _courseViewModel.addCourse(
                    courseTitle: _courseTextEditingControllers[0].text,
                    courseDescription: _courseTextEditingControllers[1].text,
                    courseImageUrl: _courseTextEditingControllers[2].text,
                    courseLessons: _lessons,
                    coursePrice: 7000,
                  );
                  _quiz.clear();
                  _lessons.clear();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Success',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            for (var each in _courseTextEditingControllers) {
                              each.clear();
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Good'),
                        ),
                      ],
                    ),
                  );
                }
                setState(() {});
              },
              child: const Text('Add course'),
            ),

            /// courses info and deleting them
            FutureBuilder(
                future: _courseViewModel.courseList,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text('error: snapshot'),
                    );
                  } else {
                    List<Course> courses = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courses.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CustomListViewBuilderContainer(
                        course: courses[index],
                        isViewStylePressed: false,
                        isDelete: true,
                        onDeletePressed: () async {
                          await _courseViewModel.deleteCourse(
                            id: courses[index].courseId,
                          );
                          setState(() {});
                        },
                      ),
                    );
                  }
                })
          ],
        ),
      ),
      drawer: CustomDrawer(
        onThemeChanged: widget.onThemeChanged,
        onBackgroundChanged: widget.onBackgroundChanged,
        onLanguageChanged: widget.onLanguageChanged,
        onColorChanged: widget.onColorChanged,
        onTextChanged: widget.onTextChanged,
      ),
    );
  }
}
