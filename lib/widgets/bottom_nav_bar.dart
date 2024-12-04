import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:homework_planner/widgets/widgets.dart';

class NavBarItem {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final String label;

  NavBarItem(this.outlinedIcon, this.filledIcon, this.label);
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      NavBarItem(Icons.home_outlined, Icons.home, 'HomeScreen.Schedule'.tr()),
      NavBarItem(Icons.assignment_outlined, Icons.assignment, 'HomeScreen.Assignments'.tr()),
      NavBarItem(Icons.notes_outlined, Icons.notes, 'HomeScreen.Notes'.tr()),
      NavBarItem(Icons.notifications_outlined, Icons.notifications, 'HomeScreen.Bells'.tr()),
      NavBarItem(Icons.leaderboard_outlined, Icons.leaderboard, 'HomeScreen.Grades'.tr()),
      NavBarItem(Icons.account_circle_outlined, Icons.account_circle, 'HomeScreen.Profile'.tr()),
    ];

    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      currentIndex: currentIndex,
      onTap: onTap,
      items: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final icon = Icon(currentIndex == index ? item.filledIcon : item.outlinedIcon);

        return BottomNavigationBarItem(
          icon: index == 1 ? AssignmentsBadge(child: icon) : icon,
          label: item.label,
        );
      }).toList(),
    );
  }
}
