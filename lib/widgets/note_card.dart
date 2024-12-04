import 'package:flutter/material.dart';

import 'package:homework_planner/models/models.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function() onTap;

  const NoteCard({
    required this.note,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card.outlined(
        key: ValueKey(note),
        color: Colors.transparent,
        elevation: 0.5,
        margin: EdgeInsets.all(6),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              note.text,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
