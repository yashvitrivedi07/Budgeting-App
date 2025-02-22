class IncomeModal {
  int? id;
  String? description, mode, date, time;
  num? amount;

  IncomeModal({
    this.amount,
    this.date,
    this.description,
    this.id,
    this.mode,
    this.time,
  });

  factory IncomeModal.toModal(Map m) {
    return IncomeModal(
      amount: m['amount'],
      date: m['date'],
      description: m['description'],
      id: m['id'],
      mode: m['mode'],
      time: m['time'],
    );
  }
}
