import 'package:flutter/material.dart';

/// OrderTrackingWidget — Displays the order progress as a vertical timeline.
///
/// This is a **pure, stateless, presentational widget**.
/// It receives only [status] (a String from [OrderEntity.status]) and renders
/// the appropriate timeline UI. No API calls, no providers, no state.
///
/// Usage inside [OrderDetailPage]:
/// ```dart
/// OrderTrackingWidget(status: order.status)
/// ```
///
/// Supported status values (case-insensitive):
///   - Pending    → Chờ xác nhận
///   - Confirmed  → Đã xác nhận
///   - Shipping   → Đang giao hàng
///   - Delivered  → Đã giao hàng
///   - Cancelled  → Đã hủy  (special cancelled timeline)
class OrderTrackingWidget extends StatelessWidget {
  final String status;

  const OrderTrackingWidget({super.key, required this.status});

  // ── Step definitions ───────────────────────────────────────────────────────

  static const _normalSteps = [
    _TrackingStep(
      status: 'pending',
      label: 'Chờ xác nhận',
      subLabel: 'Đơn hàng đang chờ xác nhận',
      icon: Icons.schedule_outlined,
    ),
    _TrackingStep(
      status: 'confirmed',
      label: 'Đã xác nhận',
      subLabel: 'Đơn hàng đã được xác nhận',
      icon: Icons.check_circle_outline,
    ),
    _TrackingStep(
      status: 'shipping',
      label: 'Đang giao hàng',
      subLabel: 'Đơn hàng đang được vận chuyển',
      icon: Icons.local_shipping_outlined,
    ),
    _TrackingStep(
      status: 'delivered',
      label: 'Đã giao hàng',
      subLabel: 'Đơn hàng đã giao thành công',
      icon: Icons.inventory_2_outlined,
    ),
  ];

  static const _cancelledSteps = [
    _TrackingStep(
      status: 'pending',
      label: 'Chờ xác nhận',
      subLabel: 'Đơn hàng đã được đặt',
      icon: Icons.schedule_outlined,
    ),
    _TrackingStep(
      status: 'cancelled',
      label: 'Đã hủy',
      subLabel: 'Đơn hàng đã bị hủy',
      icon: Icons.cancel_outlined,
    ),
  ];

  // ── Helpers ────────────────────────────────────────────────────────────────

  bool get _isCancelled => status.toLowerCase() == 'cancelled';

  List<_TrackingStep> get _steps =>
      _isCancelled ? _cancelledSteps : _normalSteps;

  /// Returns the index of the current active step (0-based).
  int get _activeIndex {
    final s = status.toLowerCase();
    if (_isCancelled) return 1; // cancelled is always the last step
    const order = ['pending', 'confirmed', 'shipping', 'delivered'];
    final idx = order.indexOf(s);
    return idx < 0 ? 0 : idx;
  }

  /// State of a step relative to [_activeIndex].
  _StepState _stateFor(int index) {
    final active = _activeIndex;
    if (index < active) return _StepState.completed;
    if (index == active) return _StepState.active;
    return _StepState.inactive;
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final steps = _steps;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          // ── Section header ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Icon(Icons.timeline_outlined, size: 18, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Trạng thái đơn hàng',
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

          // ── Timeline ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 16),
            child: Column(
              children: [
                for (int i = 0; i < steps.length; i++)
                  _buildTimelineItem(
                    step: steps[i],
                    state: _stateFor(i),
                    isLast: i == steps.length - 1,
                    colorScheme: colorScheme,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds one row of the timeline: [dot + connector] | [label + sublabel]
  Widget _buildTimelineItem({
    required _TrackingStep step,
    required _StepState state,
    required bool isLast,
    required ColorScheme colorScheme,
  }) {
    // Determine colors based on state and whether cancelled
    final Color dotColor;
    final Color connectorColor;
    final Color labelColor;
    final Color subLabelColor;
    final Color iconColor;
    final bool isCancelledStep = step.status == 'cancelled';

    switch (state) {
      case _StepState.completed:
        dotColor = colorScheme.primary;
        connectorColor = colorScheme.primary;
        labelColor = colorScheme.primary;
        subLabelColor = Colors.grey.shade500;
        iconColor = Colors.white;
      case _StepState.active:
        if (isCancelledStep) {
          dotColor = Colors.red.shade600;
          connectorColor = Colors.transparent;
          labelColor = Colors.red.shade700;
          subLabelColor = Colors.red.shade300;
          iconColor = Colors.white;
        } else {
          dotColor = colorScheme.primary;
          connectorColor = Colors.grey.shade300;
          labelColor = colorScheme.primary;
          subLabelColor = colorScheme.primary.withValues(alpha: 0.7);
          iconColor = Colors.white;
        }
      case _StepState.inactive:
        dotColor = Colors.grey.shade300;
        connectorColor = Colors.grey.shade300;
        labelColor = Colors.grey.shade500;
        subLabelColor = Colors.grey.shade400;
        iconColor = Colors.grey.shade400;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Left column: dot + vertical connector ──────────────────
          SizedBox(
            width: 32,
            child: Column(
              children: [
                // Dot
                _buildDot(
                  dotColor: dotColor,
                  iconColor: iconColor,
                  icon: state == _StepState.completed
                      ? Icons.check
                      : step.icon,
                  isActive: state == _StepState.active,
                  isCancelledStep: isCancelledStep,
                ),
                // Connector line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: connectorColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // ── Right column: label + sublabel ─────────────────────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 2,
                bottom: isLast ? 0 : 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: state != _StepState.inactive
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: labelColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    step.subLabel,
                    style: TextStyle(
                      fontSize: 11,
                      color: subLabelColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Active indicator chip ──────────────────────────────────
          if (state == _StepState.active)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isCancelledStep
                      ? Colors.red.shade50
                      : colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isCancelledStep
                        ? Colors.red.shade200
                        : colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  'Hiện tại',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isCancelledStep
                        ? Colors.red.shade700
                        : colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the circular step dot with icon inside.
  Widget _buildDot({
    required Color dotColor,
    required Color iconColor,
    required IconData icon,
    required bool isActive,
    required bool isCancelledStep,
  }) {
    final double size = isActive ? 32 : 26;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: (isCancelledStep ? Colors.red : dotColor)
                      .withValues(alpha: 0.35),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Icon(
        icon,
        size: isActive ? 16 : 13,
        color: iconColor,
      ),
    );
  }
}

// ── Internal data classes ──────────────────────────────────────────────────────

enum _StepState { completed, active, inactive }

class _TrackingStep {
  final String status;
  final String label;
  final String subLabel;
  final IconData icon;

  const _TrackingStep({
    required this.status,
    required this.label,
    required this.subLabel,
    required this.icon,
  });
}
