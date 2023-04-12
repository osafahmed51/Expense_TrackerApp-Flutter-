import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate){
          if(pickedDate==null)
            {
              return;
            }
         setState(() {
           _selectedDate=pickedDate;
         });
    });

  }

  // void submitData() {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left:10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                // onSubmitted: (_) => submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                // onSubmitted: (_) => submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Row(
                children: [
                Expanded
                  (child: Text(_selectedDate == null ? 'No Date Choosen!': 'Picked Date :${DateFormat.yMd().format(_selectedDate!)}',)),
                TextButton(onPressed: _presentDatePicker
                , child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ],
              ),
              ElevatedButton(
                  child: Text('Add Transaction',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  onPressed: () {
                    widget.addTx(titleController.text, amountController.text,_selectedDate);
                    Navigator.pop(context);
                  },style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),),
            ],
          ),
        ),
      ),
    );
  }
}
