
import '../models/course_model.dart';

class CartViewModel {
  static List<Course> list = [];
  static List<Course> fav = [];

  void addCourse(Course course) {
    bool contains = false;
    for (var element in list) {
      if (element.courseId == course.courseId) {
        contains = true;
        break;
      }
    }
    if (!contains) list.add(course);
  }

  void addFav(Course course) {
    bool contains = false;
    for (var element in fav) {
      if (element.courseId == course.courseId) {
        contains = true;
        break;
      }
    }
    if (!contains) fav.add(course);
  }
}
