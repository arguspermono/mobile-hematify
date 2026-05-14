import 'package:flutter_test/flutter_test.dart';
import 'package:hematify_android/models/transaction.dart';

void main() {
  test('Transaction toMap and fromMap serialization', () {
    final date = DateTime.parse('2026-05-14T12:00:00.000');
    final originalTx = Transaction(
      id: 1,
      title: 'Lunch',
      amount: 50000.0,
      type: 'expense',
      category: 'Food',
      date: date,
      note: 'Nasi Goreng',
    );

    // Test toMap
    final map = originalTx.toMap();
    expect(map['id'], 1);
    expect(map['title'], 'Lunch');
    expect(map['amount'], 50000.0);
    expect(map['type'], 'expense');
    expect(map['category'], 'Food');
    expect(map['date'], '2026-05-14T12:00:00.000');
    expect(map['note'], 'Nasi Goreng');

    // Test fromMap
    final parsedTx = Transaction.fromMap(map);
    expect(parsedTx.id, 1);
    expect(parsedTx.title, 'Lunch');
    expect(parsedTx.amount, 50000.0);
    expect(parsedTx.type, 'expense');
    expect(parsedTx.category, 'Food');
    expect(parsedTx.date, date);
    expect(parsedTx.note, 'Nasi Goreng');
  });
}
