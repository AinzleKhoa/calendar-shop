import 'package:flutter/material.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/order_item_entity.dart';

/// OrderItemCardWidget — renders a single [OrderItemEntity] inside the Order Detail page.
///
/// Displays:
///   - Product image thumbnail (with network image or calendar placeholder)
///   - Product name (up to 2 lines)
///   - Unit price
///   - Quantity badge
///   - Item total (unitPrice × quantity)
///
/// Input: [OrderItemEntity] only — does NOT accept models.
class OrderItemCardWidget extends StatelessWidget {
  final OrderItemEntity item;

  const OrderItemCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Product thumbnail ──────────────────────────────────────────
          _buildThumbnail(),

          const SizedBox(width: 12),

          // ── Product info ───────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  CurrencyFormatter.vnd(item.unitPrice),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // ── Quantity + total ───────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Quantity badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'x${item.quantity}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Item total
              Text(
                CurrencyFormatter.vnd(item.totalPrice),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    return SizedBox(
      width: 64,
      height: 64,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: item.productImageUrl != null && item.productImageUrl!.isNotEmpty
            ? Image.network(
                item.productImageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return _placeholder();
                },
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.blue.shade50,
      child: const Center(
        child: Icon(
          Icons.calendar_today_outlined,
          color: Colors.blueAccent,
          size: 28,
        ),
      ),
    );
  }
}
