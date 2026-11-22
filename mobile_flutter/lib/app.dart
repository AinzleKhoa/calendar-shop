import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

// Lớp CalendarShopApp giữ trách nhiệm chính của file này.
class CalendarShopApp extends StatelessWidget {
  const CalendarShopApp({super.key});

  // Dựng UI dựa trên state hiện tại.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Calendar Shop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
