import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../../utils/routes.dart';
import '../../viewmodels/cart_view_model.dart';

class CustomListViewBuilderContainer extends StatelessWidget {
  final bool isViewStylePressed;
  final Course course;
  final bool isDelete;
  final Function()? onDeletePressed;

  const CustomListViewBuilderContainer({
    super.key,
    required this.course,
    required this.isViewStylePressed,
    required this.isDelete,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.courseInfo,
          arguments: course,
        );
      },
      child: Container(
        margin: isViewStylePressed ? null : const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          // color: Colors.teal,
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.teal.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: isViewStylePressed
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Course name: ${course.courseTitle}'),
                  Text(
                      'Description:  ${course.courseDescription.split(' ')[0]}'),
                  Text('Price: ${course.coursePrice}'),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Course name: ${course.courseTitle}'),
                          Text(
                              'Description:  ${course.courseDescription.split(' ')[0]}'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('\$${course.coursePrice}'),
                          GestureDetector(
                            onTap: () {
                              CartViewModel().addCourse(course);
                            },
                            child: const Icon(Icons.add_shopping_cart),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isDelete)
                    TextButton(
                      onPressed: onDeletePressed,
                      child: const Text('Delete course'),
                    ),
                ],
              ),
      ),
    );
  }
}
