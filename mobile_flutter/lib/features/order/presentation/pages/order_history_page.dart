import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/order_provider.dart';
import '../widgets/order_card_widget.dart';

class OrderHistoryPage extends ConsumerWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderNotifierProvider);

    // Initial load without using StatefulWidget
    if (orderState.orders == null && !orderState.isLoading && orderState.error == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(orderNotifierProvider.notifier).loadOrders();
      });
    }

    Future<void> onRefresh() async {
      await ref.read(orderNotifierProvider.notifier).loadOrders();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light grey/blue background for ecommerce style
      appBar: AppBar(
        title: const Text('Lịch sử đơn hàng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: _buildBody(context, ref, orderState, onRefresh),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, orderState, Future<void> Function() onRefresh) {
    if (orderState.isLoading && (orderState.orders == null || orderState.orders!.isEmpty)) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderState.error != null && (orderState.orders == null || orderState.orders!.isEmpty)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              orderState.error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(orderNotifierProvider.notifier).loadOrders(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Thử lại', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    if (orderState.orders == null || orderState.orders!.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 150),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No orders found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 16, bottom: 32),
        itemCount: orderState.orders!.length,
        itemBuilder: (context, index) {
          final order = orderState.orders![index];
          return OrderCardWidget(order: order);
        },
      ),
    );
  }
}
