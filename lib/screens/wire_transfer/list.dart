import 'package:bytebank/models/wire_transfer.dart';
import 'package:flutter/material.dart';

import 'form.dart';

const _appBarTitle = 'Wire transfers';

class WireTransferList extends StatefulWidget {

  final List<WireTransfer> wireTransfersList = List();

  @override
  State<StatefulWidget> createState() {
    return WireTransferListState();
  }
}

class WireTransferListState extends State<WireTransferList> {

  addWireTransferToList(WireTransfer wireTransfer) {
    if (wireTransfer == null)
      return;
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
        title: Text(_appBarTitle),
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