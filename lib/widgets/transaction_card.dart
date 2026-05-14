import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncome = transaction.type == 'income';
    final String formattedDate = DateFormat('dd MMM yyyy').format(transaction.date);
    final String formattedAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(transaction.amount);

    final IconData categoryIcon;
    switch (transaction.category) {
      case 'Salary': categoryIcon = Icons.payments_outlined; break;
      case 'Freelance': categoryIcon = Icons.laptop_mac_outlined; break;
      case 'Gift': categoryIcon = Icons.card_giftcard_outlined; break;
      case 'Food': categoryIcon = Icons.restaurant_outlined; break;
      case 'Transport': categoryIcon = Icons.directions_bus_outlined; break;
      case 'Shopping': categoryIcon = Icons.shopping_bag_outlined; break;
      case 'Health': categoryIcon = Icons.medical_services_outlined; break;
      case 'Bills': categoryIcon = Icons.receipt_long_outlined; break;
      default: categoryIcon = Icons.category_outlined;
    }

    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isIncome ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            categoryIcon,
            color: isIncome ? Colors.green.shade700 : Colors.red.shade700,
          ),
        ),
        title: Text(
          transaction.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.category,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            Text(
              formattedDate,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
            ),
          ],
        ),
        trailing: Text(
          '${isIncome ? "+" : "-"}$formattedAmount',
          style: TextStyle(
            color: isIncome ? Colors.green.shade700 : Colors.red.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
