import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: WireTransferList(),
      ),
    );
  }
}

class WireTransferForm extends StatelessWidget {
  final TextEditingController _controllerAccountNumberField =
      TextEditingController();
  final TextEditingController _controllerValueField = TextEditingController();

  createWireTransfer(BuildContext context) {
    final String accountNumber = this._controllerAccountNumberField.text;
    final double value = double.tryParse(this._controllerValueField.text);

    if (value != null) {
      final newWireTransfer = WireTransfer(value, accountNumber);

      Navigator.pop(context, newWireTransfer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New wire transfer')),
      body: Column(
        children: <Widget>[
          FormInput(
            controller: _controllerAccountNumberField,
            label: 'Account Number',
            hint: '00000-0',
          ),
          FormInput(
            controller: _controllerValueField,
            label: 'Value to be transferred',
            hint: '00.00',
            icon: Icons.monetization_on,
          ),
          RaisedButton(
            child: Text('Confirm'),
            onPressed: () => createWireTransfer(context),
          ),
        ],
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  
  const FormInput({
    this.controller,
    this.label,
    this.hint,
    this.icon
  });

  getIcon() {
    return (this.icon != null) ? Icon(this.icon) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: getIcon(),
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}

class WireTransferList extends StatefulWidget {

  final List<WireTransfer> wireTransfersList = List();

  @override
  State<StatefulWidget> createState() {
    return WireTransferListState();
  }
}

class WireTransferListState extends State<WireTransferList> {

  addWireTransferToList(WireTransfer wireTransfer) {
    setState(() { widget.wireTransfersList.add(wireTransfer); });
  }

  buildItem(BuildContext context, int index) {
    final wireTransfer = widget.wireTransfersList[index];

    return WireTransferItem(wireTransfer);
  }

  redirectToForm(BuildContext context) {
    final route = MaterialPageRoute<WireTransfer>(
        builder: (context) => WireTransferForm()
    );

    final Future<WireTransfer> future = Navigator.push(context, route);
    future.then((wireTransfer) => addWireTransferToList(wireTransfer));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wire Transfers'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 8.0),
        itemCount: widget.wireTransfersList.length,
        itemBuilder: (BuildContext context, int index) =>
          buildItem(context, index),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => redirectToForm(context),
      ),
    );
  }
}

class WireTransferItem extends StatelessWidget {
  final WireTransfer _wireTransfer;

  const WireTransferItem(this._wireTransfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_wireTransfer.valueToCurrency()),
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
    final value = this.valueToCurrency();
    final accountNumber = this.accountNumber;

    return 'Wire transfer to $accountNumber of value $value';
  }

  String valueToCurrency() {
    final value = this.value.toString();
    return '\$$value';
  }
}
