class RecentModal {
  String? type, time, date, mode, description;
  int? id;
  num? amount;

  RecentModal(
      {this.amount,
      this.date,
      this.description,
      this.id,
      this.mode,
      this.time,
      this.type});

  factory RecentModal.toModal(Map m) {
    return RecentModal(
        amount: m['amount'],
        date: m['date'],
        description: m['description'],
        id: m['id'],
        mode: m['mode'],
        time: m['time'],
        type: m['type']);
  }
}