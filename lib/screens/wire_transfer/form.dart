import 'package:bytebank/components/form_input.dart';
import 'package:bytebank/models/wire_transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'New wire transfer';

const _labelAccountNumberField = 'Account number';
const _hintAccountNumberField = '00000-0';

const _labelValueField = 'Value to be transferred';
const _hintValueField = '00.00';

const _labelConfirmButton = 'Confirm';

class WireTransferForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return WireTransferFormState();
  }
}

class WireTransferFormState extends State<WireTransferForm> {

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
      appBar: AppBar(title: Text(_appBarTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormInput(
              controller: _controllerAccountNumberField,
              label: _labelAccountNumberField,
              hint: _hintAccountNumberField,
            ),
            FormInput(
              controller: _controllerValueField,
              label: _labelValueField,
              hint: _hintValueField,
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text(_labelConfirmButton),
              onPressed: () => createWireTransfer(context),
            ),
          ],
        ),
      ),
    );
  }
}