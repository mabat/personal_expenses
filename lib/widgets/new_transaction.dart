import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({@required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;

      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: _titleController,
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                controller: _amountController,
                onFieldSubmitted: (_) =>
                    _submitData(), // '_' is by convention and means "i don't need it"
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No Date Choosen!"
                          : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                  onPressed: _submitData,
                  child: Text(
                    "Add transaction",
                    style: TextStyle(color: Colors.purple),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
