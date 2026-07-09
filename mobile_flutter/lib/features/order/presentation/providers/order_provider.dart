import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/cancel_order_usecase.dart';
import '../../domain/usecases/get_my_orders_usecase.dart';
import '../../domain/usecases/get_order_detail_usecase.dart';
import 'order_state.dart';

part 'order_provider.g.dart';

@riverpod
OrderRemoteDataSource orderRemoteDataSource(OrderRemoteDataSourceRef ref) {
  return OrderRemoteDataSource(ref.watch(apiClientProvider));
}

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepositoryImpl(ref.watch(orderRemoteDataSourceProvider));
}

@riverpod
GetMyOrdersUseCase getMyOrdersUseCase(GetMyOrdersUseCaseRef ref) {
  return GetMyOrdersUseCase(ref.watch(orderRepositoryProvider));
}

@riverpod
GetOrderDetailUseCase getOrderDetailUseCase(GetOrderDetailUseCaseRef ref) {
  return GetOrderDetailUseCase(ref.watch(orderRepositoryProvider));
}

@riverpod
CancelOrderUseCase cancelOrderUseCase(CancelOrderUseCaseRef ref) {
  return CancelOrderUseCase(ref.watch(orderRepositoryProvider));
}

@riverpod
class OrderNotifier extends _$OrderNotifier {
  @override
  OrderState build() {
    return const OrderState();
  }

  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final orders = await ref.read(getMyOrdersUseCaseProvider)();
      state = state.copyWith(isLoading: false, orders: orders);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadOrderDetail(int orderId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final order = await ref.read(getOrderDetailUseCaseProvider)(orderId);
      state = state.copyWith(isLoading: false, selectedOrder: order);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> cancelOrder(int id, String reason) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(cancelOrderUseCaseProvider)(id, reason);
      state = state.copyWith(isLoading: false);
      // Reload order list and detail
      await loadOrders();
      await loadOrderDetail(id);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
