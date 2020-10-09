import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: WireTransferForm(),
      ),
    );
  }
}

class WireTransferForm extends StatelessWidget {
  final TextEditingController _controllerAccountNumberField =
      TextEditingController();
  final TextEditingController _controllerValueField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New wire transfer')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controllerAccountNumberField,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                labelText: 'Account number',
                hintText: '00000-0',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controllerValueField,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: 'Value to be transferred',
                hintText: '00.0',
              ),
            ),
          ),
          RaisedButton(
            child: Text('Confirm'),
            onPressed: () {
              final String accountNumber = _controllerAccountNumberField.text;
              final double value = double.tryParse(_controllerValueField.text);

              if (value != null) {
                final newWireTransfer = WireTransfer(value, accountNumber);
                final newWireTransferToString = newWireTransfer.toString();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$newWireTransferToString'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class WireTransferList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wire Transfers'),
      ),
      body: Column(
        children: [
          WireTransferItem(new WireTransfer(100.0, "64321-0")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class WireTransferItem extends StatelessWidget {
  final WireTransfer _wireTransfer;

  const WireTransferItem(this._wireTransfer);

  getValueAsCurrency() {
    final valueAsString = this._wireTransfer.value.toString();
    final valueAsCurrency = 'R\$' + valueAsString;
    return valueAsCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(getValueAsCurrency()),
        subtitle: Text(_wireTransfer.accountNumber),
      ),
    );
  }
}

class WireTransfer {
  final double value;
  final String accountNumber;

  WireTransfer(this.value, this.accountNumber);

  @override
  String toString() {
    final value = this.value;
    final accountNumber = this.accountNumber;

    return 'Wire transfer to $accountNumber of value $value';
  }
}
