import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      body: WireTransferList(),
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    ),
  ),
);

class WireTransferList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WireTransferItem(new WireTransfer(100.0, "64321-0")),
      ],
    );
  }
}

class WireTransferItem extends StatelessWidget {

  final WireTransfer _wireTransfer;

  const WireTransferItem(this._wireTransfer);

  getValueAsCurrency() {
    final valueAsString =  this
        ._wireTransfer.value.toString();
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
}