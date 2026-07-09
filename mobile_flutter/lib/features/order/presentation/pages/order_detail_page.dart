import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/order_provider.dart';
import '../widgets/order_item_card_widget.dart';
import '../widgets/order_status_badge_widget.dart';
import '../widgets/order_tracking_widget.dart';

/// OrderDetailPage — Shows complete details for a single order.
///
/// Route  : /orders/:id
/// Receives: [orderId] from router path parameter.
///
/// Data flow:
///   initState → orderNotifierProvider.notifier.loadOrderDetail(orderId)
///             → OrderState.selectedOrder populated
///             → UI rebuilds via ref.watch
class OrderDetailPage extends ConsumerStatefulWidget {
  final int orderId;

  const OrderDetailPage({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends ConsumerState<OrderDetailPage> {
  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderNotifierProvider.notifier).loadOrderDetail(widget.orderId);
    });
  }

  // ── Actions ────────────────────────────────────────────────────────────────

  Future<void> _refresh() async {
    await ref.read(orderNotifierProvider.notifier).loadOrderDetail(widget.orderId);
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _CancelOrderDialog(
        orderId: widget.orderId,
        onConfirm: (reason) async {
          Navigator.of(ctx).pop();

          // Call provider — never call repository/API directly
          await ref
              .read(orderNotifierProvider.notifier)
              .cancelOrder(widget.orderId, reason);

          if (!context.mounted) return;

          // Check if provider surfaced an error
          final error = ref.read(orderNotifierProvider).error;
          if (error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Không thể hủy đơn hàng. Vui lòng thử lại.'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Hủy đơn hàng thành công'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(colorScheme),
      body: _buildBody(orderState, colorScheme),
    );
  }

  AppBar _buildAppBar(ColorScheme colorScheme) {
    return AppBar(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: 'Quay lại',
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chi tiết đơn hàng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            '#ORD${widget.orderId.toString().padLeft(3, '0')}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // ── State Handling ─────────────────────────────────────────────────────────

  Widget _buildBody(dynamic orderState, ColorScheme colorScheme) {
    // Loading state
    if (orderState.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Đang tải đơn hàng...',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Error state
    if (orderState.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              const Text(
                'Không thể tải đơn hàng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                orderState.error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _refresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Thử lại'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Not found / empty state
    final order = orderState.selectedOrder;
    if (order == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Không tìm thấy đơn hàng',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // Success state
    return _buildOrderContent(order, colorScheme);
  }

  // ── Order Content ──────────────────────────────────────────────────────────

  Widget _buildOrderContent(OrderEntity order, ColorScheme colorScheme) {
    final isPending = order.status.toLowerCase() == 'pending';

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: isPending ? 96 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Status banner ───────────────────────────────────────
                _buildStatusBanner(order, colorScheme),

                const SizedBox(height: 12),

                // ── Order info ──────────────────────────────────────────
                _buildSection(
                  icon: Icons.receipt_long_outlined,
                  title: 'Thông tin đơn hàng',
                  colorScheme: colorScheme,
                  child: _buildOrderInfoRows(order),
                ),

                const SizedBox(height: 10),

                // ── Order tracking timeline ─────────────────────────────
                OrderTrackingWidget(status: order.status),

                const SizedBox(height: 10),

                // ── Shipping / customer info ────────────────────────────
                _buildSection(
                  icon: Icons.location_on_outlined,
                  title: 'Địa chỉ giao hàng',
                  colorScheme: colorScheme,
                  child: _buildShippingRows(order, colorScheme),
                ),

                const SizedBox(height: 10),

                // ── Product list ────────────────────────────────────────
                _buildSection(
                  icon: Icons.shopping_bag_outlined,
                  title: 'Sản phẩm (${order.items.length})',
                  colorScheme: colorScheme,
                  child: Column(
                    children: order.items
                        .map((item) => OrderItemCardWidget(item: item))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 10),

                // ── Payment summary ─────────────────────────────────────
                _buildSection(
                  icon: Icons.payments_outlined,
                  title: 'Tóm tắt thanh toán',
                  colorScheme: colorScheme,
                  child: _buildPaymentSummary(order, colorScheme),
                ),

                const SizedBox(height: 10),

                // ── Payment method row ──────────────────────────────────
                _buildSection(
                  icon: Icons.credit_card_outlined,
                  title: 'Phương thức thanh toán',
                  colorScheme: colorScheme,
                  child: _buildPaymentMethodRow(order, colorScheme),
                ),
              ],
            ),
          ),
        ),

        // ── Cancel button (Pending only) ────────────────────────────────
        if (isPending)
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _showCancelDialog(context),
                icon: const Icon(Icons.cancel_outlined),
                label: const Text(
                  'Hủy đơn hàng',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ── Sub-widgets ────────────────────────────────────────────────────────────

  /// Blue banner at the top showing status badge prominently
  Widget _buildStatusBanner(OrderEntity order, ColorScheme colorScheme) {
    final dateFormatter = DateFormat('dd/MM/yyyy • HH:mm');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status badge
          OrderStatusBadgeWidget(status: order.status),
          const SizedBox(height: 10),
          // Order ID
          Text(
            '#ORD${order.orderId.toString().padLeft(3, '0')}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          // Date
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 13, color: Colors.white70),
              const SizedBox(width: 4),
              Text(
                dateFormatter.format(order.createdAt),
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Reusable card section with icon + title header
  Widget _buildSection({
    required IconData icon,
    required String title,
    required ColorScheme colorScheme,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Icon(icon, size: 18, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 16),
          ),
          // Section content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: child,
          ),
        ],
      ),
    );
  }

  /// Order ID, date, cancel reason rows
  Widget _buildOrderInfoRows(OrderEntity order) {
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm');
    return Column(
      children: [
        _labelValueRow('Mã đơn hàng', '#ORD${order.orderId.toString().padLeft(3, '0')}'),
        _labelValueRow('Ngày đặt hàng', dateFormatter.format(order.createdAt)),
        if (order.note != null && order.note!.isNotEmpty)
          _labelValueRow('Ghi chú', order.note!),
        if (order.cancelReason != null && order.cancelReason!.isNotEmpty)
          _labelValueRow('Lý do hủy', order.cancelReason!, valueColor: Colors.red),
      ],
    );
  }

  /// Customer name, phone, shipping address
  Widget _buildShippingRows(OrderEntity order, ColorScheme colorScheme) {
    return Column(
      children: [
        // Name + phone row
        _iconLabelRow(
          icon: Icons.person_outline,
          label: order.customerName,
          sub: order.customerPhone,
          colorScheme: colorScheme,
        ),
        const Divider(height: 16),
        // Address row
        _iconLabelRow(
          icon: Icons.location_on_outlined,
          label: order.shippingAddress,
          colorScheme: colorScheme,
        ),
      ],
    );
  }

  /// Subtotal / discount / shipping / total
  Widget _buildPaymentSummary(OrderEntity order, ColorScheme colorScheme) {
    return Column(
      children: [
        _priceRow('Tạm tính', order.subTotal),
        if (order.discountAmount > 0) ...[
          const SizedBox(height: 2),
          _priceRow(
            'Giảm giá',
            order.discountAmount,
            isDiscount: true,
          ),
        ],
        const SizedBox(height: 2),
        _priceRow('Phí vận chuyển', order.shippingFee),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(height: 1),
        ),
        // Total row — larger, blue
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tổng tiền',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              CurrencyFormatter.vnd(order.totalAmount),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Payment method row with card icon
  Widget _buildPaymentMethodRow(OrderEntity order, ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _paymentIcon(order.paymentMethod),
            size: 20,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.paymentMethod,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                _paymentDescription(order.paymentMethod),
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade400),
      ],
    );
  }

  // ── Helper widgets ─────────────────────────────────────────────────────────

  Widget _labelValueRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconLabelRow({
    required IconData icon,
    required String label,
    String? sub,
    required ColorScheme colorScheme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              if (sub != null) ...[
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _priceRow(String label, double amount, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          Text(
            isDiscount
                ? '-${CurrencyFormatter.vnd(amount)}'
                : CurrencyFormatter.vnd(amount),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDiscount ? Colors.green.shade700 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ── Utilities ──────────────────────────────────────────────────────────────

  IconData _paymentIcon(String method) {
    final m = method.toLowerCase();
    if (m.contains('cod') || m.contains('tiền mặt')) return Icons.payments_outlined;
    if (m.contains('bank') || m.contains('chuyển khoản')) return Icons.account_balance_outlined;
    if (m.contains('card') || m.contains('thẻ')) return Icons.credit_card_outlined;
    return Icons.payment_outlined;
  }

  String _paymentDescription(String method) {
    final m = method.toLowerCase();
    if (m.contains('cod') || m.contains('tiền mặt')) {
      return 'Thanh toán khi nhận hàng (COD)';
    }
    if (m.contains('bank') || m.contains('chuyển khoản')) {
      return 'Chuyển khoản ngân hàng';
    }
    return 'Thanh toán online';
  }
}

// ── Private dialog widget ──────────────────────────────────────────────────────

/// _CancelOrderDialog — Self-contained dialog with inline reason validation.
///
/// Uses its own [State] only to show/hide validation error text.
/// Does NOT manage order data — that stays in [orderNotifierProvider].
///
/// Business rules enforced:
///   - [reason] must not be empty before [onConfirm] is called.
///   - Shows "Vui lòng nhập lý do hủy" when user attempts to submit empty.
class _CancelOrderDialog extends StatefulWidget {
  final int orderId;
  final Future<void> Function(String reason) onConfirm;

  const _CancelOrderDialog({
    required this.orderId,
    required this.onConfirm,
  });

  @override
  State<_CancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<_CancelOrderDialog> {
  final _reasonController = TextEditingController();
  String? _validationError;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final reason = _reasonController.text.trim();

    // Validation: reason must not be empty
    if (reason.isEmpty) {
      setState(() => _validationError = 'Vui lòng nhập lý do hủy');
      return;
    }

    setState(() {
      _validationError = null;
      _isSubmitting = true;
    });

    // Delegate to page — never calls API/repo directly
    await widget.onConfirm(reason);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // ── Title ────────────────────────────────────────────────────────────
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red.shade600, size: 22),
          const SizedBox(width: 8),
          const Text(
            'Hủy đơn hàng?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
      // ── Content ──────────────────────────────────────────────────────────
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Confirmation question
          Text(
            'Bạn có chắc muốn hủy đơn này không?',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 16),
          // Reason label
          const Text(
            'Lý do hủy đơn',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // Reason input
          TextField(
            controller: _reasonController,
            maxLines: 3,
            enabled: !_isSubmitting,
            onChanged: (_) {
              if (_validationError != null) {
                setState(() => _validationError = null);
              }
            },
            decoration: InputDecoration(
              hintText: 'Lý do hủy đơn',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: _validationError != null
                      ? Colors.red.shade400
                      : Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: _validationError != null
                      ? Colors.red.shade400
                      : colorScheme.primary,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red.shade400),
              ),
              contentPadding: const EdgeInsets.all(12),
              // Inline validation error
              errorText: _validationError,
            ),
          ),
        ],
      ),
      // ── Actions ──────────────────────────────────────────────────────────
      actions: [
        // Close button
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: Text(
            'Đóng',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        // Confirm button
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.red.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  'Xác nhận hủy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }
}

