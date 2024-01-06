import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/transaction.dart';

class TransactionDialog extends StatefulWidget {
  final Transaction? transaction;
  final Function(String name, double amount, bool isExpense)? onClickedDone;
  final Function()? onClickedDelete;

  const TransactionDialog({
    Key? key,
    this.transaction,
    this.onClickedDone,
    this.onClickedDelete,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  bool isExpense = true;

  static const _color = const Color(0xff008037);

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      nameController.text = widget.transaction!.name;
      amountController.text = "${widget.transaction!.amount}";
      isExpense = widget.transaction!.isExpense;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        title,
        style: TextStyle(color: _color),
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildName(),
              SizedBox(height: 8),
              _buildAmount(),
              SizedBox(height: 8),
              _buildRadioButtons(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        _buildCancelButton(context),
        if (isEditing) _buildDeleteButton(context),
        _buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget _buildName() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }

  Widget _buildAmount() {
    return TextFormField(
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Amount',
      ),
      validator: (value) {
        if (value != null && double.tryParse(value) == null) {
          return 'Please enter a valid amount';
        }
        return null;
      },
    );
  }

  Widget _buildRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile<bool>(
          title: Text('Expense'),
          value: true,
          groupValue: isExpense,
          onChanged: (value) => setState(() => isExpense = value!),
        ),
        RadioListTile<bool>(
          title: Text('Income'),
          value: false,
          groupValue: isExpense,
          onChanged: (value) => setState(() => isExpense = value!),
        ),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Cancel',
        style: TextStyle(
          color: _color,
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      label: Text(
        'Delete',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: widget.onClickedDelete != null ? () =>
          widget.onClickedDelete!() : null,
    );
  }

  Widget _buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          color: _color,
        ),
      ),
      onPressed: () {
        final isValid = formKey.currentState!.validate();
        if (isValid && widget.onClickedDone != null) {
          final name = nameController.text;
          final amount = double.tryParse(amountController.text) ?? 0.0;
          final isExpense = this.isExpense;
          widget.onClickedDone!(name, amount, isExpense);
          // Remove the Navigator.of(context).pop() line to keep the expense page open
        }
      },
    );
  }

}