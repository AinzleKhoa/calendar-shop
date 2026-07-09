import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_entity.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState({
    @Default(false) bool isLoading,
    List<OrderEntity>? orders,
    OrderEntity? selectedOrder,
    String? error,
  }) = _OrderState;
}
