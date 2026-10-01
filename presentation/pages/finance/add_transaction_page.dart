import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/transaction_type.dart';
import '../../../data/models/finance_transaction_model.dart';
import '../../../providers/finance_provider.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _descriptionController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final transaction = FinanceTransactionModel(
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text.replaceAll(',', '')),
      type: _selectedType,
      description: _descriptionController.text.trim(),
      transactionDate: DateTime.now(),
      createdAt: DateTime.now(),
    );

    await context.read<FinanceProvider>().addTransaction(transaction);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ثبت تراکنش')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'عنوان'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'عنوان را وارد کنید';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'مبلغ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'مبلغ را وارد کنید';
                  }

                  if (double.tryParse(value.replaceAll(',', '')) == null) {
                    return 'مبلغ معتبر نیست';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<TransactionType>(
                initialValue: _selectedType,
                decoration: const InputDecoration(labelText: 'نوع تراکنش'),
                items: TransactionType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(switch (type) {
                      TransactionType.income => 'درآمد',
                      TransactionType.expense => 'هزینه',
                      TransactionType.saving => 'پس‌انداز',
                    }),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'توضیحات'),
              ),

              const SizedBox(height: 30),

              ElevatedButton(onPressed: _save, child: const Text('ثبت تراکنش')),
            ],
          ),
        ),
      ),
    );
  }
}
