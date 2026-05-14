import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';

class AddEditScreen extends StatefulWidget {
  final Transaction? existing;

  const AddEditScreen({super.key, this.existing});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late TextEditingController _noteController;

  late String _selectedType;
  late String _selectedCategory;
  late DateTime _selectedDate;

  final Map<String, List<String>> _categories = {
    'income': ['Salary', 'Freelance', 'Gift', 'Other'],
    'expense': ['Food', 'Transport', 'Shopping', 'Health', 'Bills', 'Other'],
  };

  @override
  void initState() {
    super.initState();
    final t = widget.existing;
    
    _titleController = TextEditingController(text: t?.title ?? '');
    _amountController = TextEditingController(text: t?.amount != null ? t!.amount.toStringAsFixed(0) : '');
    _noteController = TextEditingController(text: t?.note ?? '');
    
    _selectedType = t?.type ?? 'expense';
    _selectedCategory = t?.category ?? _categories[_selectedType]!.first;
    _selectedDate = t?.date ?? DateTime.now();
    
    _dateController = TextEditingController(
      text: DateFormat('dd MMM yyyy').format(_selectedDate),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final t = Transaction(
      id: widget.existing?.id,
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text),
      type: _selectedType,
      category: _selectedCategory,
      date: _selectedDate,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
    );

    final provider = context.read<TransactionProvider>();
    if (widget.existing == null) {
      provider.add(t);
    } else {
      provider.update(t);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Transaction' : 'Add Transaction'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Type Selection
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'income', label: Text('Income'), icon: Icon(Icons.add)),
                  ButtonSegment(value: 'expense', label: Text('Expense'), icon: Icon(Icons.remove)),
                ],
                selected: {_selectedType},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _selectedType = newSelection.first;
                    // Reset category if current one is not in the new list
                    if (!_categories[_selectedType]!.contains(_selectedCategory)) {
                      _selectedCategory = _categories[_selectedType]!.first;
                    }
                  });
                },
              ),
              const SizedBox(height: 24),
              
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              
              // Amount
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter an amount';
                  final n = double.tryParse(v);
                  if (n == null) return 'Please enter a valid number';
                  if (n <= 0) return 'Amount must be greater than zero';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Category
              DropdownButtonFormField<String>(
                key: ValueKey(_selectedType),
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories[_selectedType]!
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCategory = v!),
                validator: (v) => v == null || v.isEmpty ? 'Please select a category' : null,
              ),
              const SizedBox(height: 16),
              
              // Date
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: _pickDate,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 16),
              
              // Note
              TextFormField(
                controller: _noteController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Note (Optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
              ),
              const SizedBox(height: 32),
              
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text(isEdit ? 'Save Changes' : 'Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
