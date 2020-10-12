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