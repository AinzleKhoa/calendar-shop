// my_orders_page.dart
// This file keeps the route-compatible class name used by app_router.dart.
// The implementation delegates to OrderHistoryPage.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_history_page.dart';

/// MyOrdersPage is an alias kept for router compatibility.
/// All logic lives in [OrderHistoryPage].
class MyOrdersPage extends ConsumerWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const OrderHistoryPage();
  }
}
