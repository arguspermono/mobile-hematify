import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../database/db_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _allTransactions = [];
  DateTimeRange? _filter;

  DateTimeRange? get filterRange => _filter;

  List<Transaction> get transactions {
    if (_filter == null) {
      return _allTransactions;
    }
    // Simple date range filter (inclusive)
    return _allTransactions.where((t) {
      final date = t.date;
      return date.isAfter(_filter!.start.subtract(const Duration(seconds: 1))) &&
             date.isBefore(_filter!.end.add(const Duration(days: 1)));
    }).toList();
  }

  double get totalIncome {
    return transactions
        .where((t) => t.type == 'income')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get balance => totalIncome - totalExpense;

  Future<void> load() async {
    _allTransactions = await DBHelper.instance.queryAll();
    notifyListeners();
  }

  Future<void> add(Transaction transaction) async {
    await DBHelper.instance.insert(transaction);
    await load();
  }

  Future<void> update(Transaction transaction) async {
    await DBHelper.instance.update(transaction);
    await load();
  }

  Future<void> delete(int id) async {
    await DBHelper.instance.delete(id);
    await load();
  }

  void setFilter(DateTimeRange? range) {
    _filter = range;
    notifyListeners();
  }
}
