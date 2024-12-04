import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:homework_planner/screens/screens.dart';
import 'package:homework_planner/models/models.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class Routes extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: ScheduleRoute.page),
            AutoRoute(page: AssignmentsRoute.page),
            AutoRoute(page: NotesRoute.page),
            AutoRoute(page: GradesRoute.page),
            AutoRoute(page: BellsRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: SubjectsRoute.page),
        AutoRoute(page: TeachersRoute.page),
        AutoRoute(page: TermsRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: HelpRoute.page),
        //
        AutoRoute(page: HomeworkRoute.page),
        AutoRoute(page: ImageRoute.page),
        AutoRoute(page: NoteDetailRoute.page),
        AutoRoute(page: SubjectDetailRoute.page),
        AutoRoute(page: TeacherDetailRoute.page),
        AutoRoute(page: TermDetailRoute.page),
        AutoRoute(page: GradesHistoryRoute.page),
      ];
}
