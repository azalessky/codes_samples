// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [AssignmentsScreen]
class AssignmentsRoute extends PageRouteInfo<void> {
  const AssignmentsRoute({List<PageRouteInfo>? children})
      : super(
          AssignmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AssignmentsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AssignmentsScreen();
    },
  );
}

/// generated route for
/// [BellsScreen]
class BellsRoute extends PageRouteInfo<void> {
  const BellsRoute({List<PageRouteInfo>? children})
      : super(
          BellsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BellsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BellsScreen();
    },
  );
}

/// generated route for
/// [GradesHistoryScreen]
class GradesHistoryRoute extends PageRouteInfo<GradesHistoryRouteArgs> {
  GradesHistoryRoute({
    required String subject,
    required DateTime start,
    required DateTime end,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          GradesHistoryRoute.name,
          args: GradesHistoryRouteArgs(
            subject: subject,
            start: start,
            end: end,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'GradesHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GradesHistoryRouteArgs>();
      return GradesHistoryScreen(
        subject: args.subject,
        start: args.start,
        end: args.end,
        key: args.key,
      );
    },
  );
}

class GradesHistoryRouteArgs {
  const GradesHistoryRouteArgs({
    required this.subject,
    required this.start,
    required this.end,
    this.key,
  });

  final String subject;

  final DateTime start;

  final DateTime end;

  final Key? key;

  @override
  String toString() {
    return 'GradesHistoryRouteArgs{subject: $subject, start: $start, end: $end, key: $key}';
  }
}

/// generated route for
/// [GradesScreen]
class GradesRoute extends PageRouteInfo<void> {
  const GradesRoute({List<PageRouteInfo>? children})
      : super(
          GradesRoute.name,
          initialChildren: children,
        );

  static const String name = 'GradesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GradesScreen();
    },
  );
}

/// generated route for
/// [HelpScreen]
class HelpRoute extends PageRouteInfo<void> {
  const HelpRoute({List<PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HelpScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [HomeworkScreen]
class HomeworkRoute extends PageRouteInfo<HomeworkRouteArgs> {
  HomeworkRoute({
    required Period period,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeworkRoute.name,
          args: HomeworkRouteArgs(
            period: period,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeworkRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeworkRouteArgs>();
      return HomeworkScreen(
        args.period,
        key: args.key,
      );
    },
  );
}

class HomeworkRouteArgs {
  const HomeworkRouteArgs({
    required this.period,
    this.key,
  });

  final Period period;

  final Key? key;

  @override
  String toString() {
    return 'HomeworkRouteArgs{period: $period, key: $key}';
  }
}

/// generated route for
/// [ImageScreen]
class ImageRoute extends PageRouteInfo<ImageRouteArgs> {
  ImageRoute({
    required String image,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ImageRoute.name,
          args: ImageRouteArgs(
            image: image,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ImageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImageRouteArgs>();
      return ImageScreen(
        args.image,
        key: args.key,
      );
    },
  );
}

class ImageRouteArgs {
  const ImageRouteArgs({
    required this.image,
    this.key,
  });

  final String image;

  final Key? key;

  @override
  String toString() {
    return 'ImageRouteArgs{image: $image, key: $key}';
  }
}

/// generated route for
/// [NoteDetailScreen]
class NoteDetailRoute extends PageRouteInfo<NoteDetailRouteArgs> {
  NoteDetailRoute({
    String? noteId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NoteDetailRoute.name,
          args: NoteDetailRouteArgs(
            noteId: noteId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'NoteDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NoteDetailRouteArgs>(
          orElse: () => const NoteDetailRouteArgs());
      return NoteDetailScreen(
        noteId: args.noteId,
        key: args.key,
      );
    },
  );
}

class NoteDetailRouteArgs {
  const NoteDetailRouteArgs({
    this.noteId,
    this.key,
  });

  final String? noteId;

  final Key? key;

  @override
  String toString() {
    return 'NoteDetailRouteArgs{noteId: $noteId, key: $key}';
  }
}

/// generated route for
/// [NotesScreen]
class NotesRoute extends PageRouteInfo<void> {
  const NotesRoute({List<PageRouteInfo>? children})
      : super(
          NotesRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotesScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [ScheduleScreen]
class ScheduleRoute extends PageRouteInfo<void> {
  const ScheduleRoute({List<PageRouteInfo>? children})
      : super(
          ScheduleRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScheduleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScheduleScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [SubjectDetailScreen]
class SubjectDetailRoute extends PageRouteInfo<SubjectDetailRouteArgs> {
  SubjectDetailRoute({
    String? subjectId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SubjectDetailRoute.name,
          args: SubjectDetailRouteArgs(
            subjectId: subjectId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SubjectDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubjectDetailRouteArgs>(
          orElse: () => const SubjectDetailRouteArgs());
      return SubjectDetailScreen(
        subjectId: args.subjectId,
        key: args.key,
      );
    },
  );
}

class SubjectDetailRouteArgs {
  const SubjectDetailRouteArgs({
    this.subjectId,
    this.key,
  });

  final String? subjectId;

  final Key? key;

  @override
  String toString() {
    return 'SubjectDetailRouteArgs{subjectId: $subjectId, key: $key}';
  }
}

/// generated route for
/// [SubjectsScreen]
class SubjectsRoute extends PageRouteInfo<void> {
  const SubjectsRoute({List<PageRouteInfo>? children})
      : super(
          SubjectsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubjectsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SubjectsScreen();
    },
  );
}

/// generated route for
/// [TeacherDetailScreen]
class TeacherDetailRoute extends PageRouteInfo<TeacherDetailRouteArgs> {
  TeacherDetailRoute({
    String? teacherId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TeacherDetailRoute.name,
          args: TeacherDetailRouteArgs(
            teacherId: teacherId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TeacherDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TeacherDetailRouteArgs>(
          orElse: () => const TeacherDetailRouteArgs());
      return TeacherDetailScreen(
        teacherId: args.teacherId,
        key: args.key,
      );
    },
  );
}

class TeacherDetailRouteArgs {
  const TeacherDetailRouteArgs({
    this.teacherId,
    this.key,
  });

  final String? teacherId;

  final Key? key;

  @override
  String toString() {
    return 'TeacherDetailRouteArgs{teacherId: $teacherId, key: $key}';
  }
}

/// generated route for
/// [TeachersScreen]
class TeachersRoute extends PageRouteInfo<void> {
  const TeachersRoute({List<PageRouteInfo>? children})
      : super(
          TeachersRoute.name,
          initialChildren: children,
        );

  static const String name = 'TeachersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TeachersScreen();
    },
  );
}

/// generated route for
/// [TermDetailScreen]
class TermDetailRoute extends PageRouteInfo<TermDetailRouteArgs> {
  TermDetailRoute({
    String? termId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TermDetailRoute.name,
          args: TermDetailRouteArgs(
            termId: termId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TermDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TermDetailRouteArgs>(
          orElse: () => const TermDetailRouteArgs());
      return TermDetailScreen(
        termId: args.termId,
        key: args.key,
      );
    },
  );
}

class TermDetailRouteArgs {
  const TermDetailRouteArgs({
    this.termId,
    this.key,
  });

  final String? termId;

  final Key? key;

  @override
  String toString() {
    return 'TermDetailRouteArgs{termId: $termId, key: $key}';
  }
}

/// generated route for
/// [TermsScreen]
class TermsRoute extends PageRouteInfo<void> {
  const TermsRoute({List<PageRouteInfo>? children})
      : super(
          TermsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TermsScreen();
    },
  );
}
