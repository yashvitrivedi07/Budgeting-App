import 'dart:typed_data';

class ExpenseModal {
  int? id;
  String? description, category, mode, date, time;
  num? amount;
  Uint8List? img;

  ExpenseModal(
      {this.amount,
      this.category,
      this.date,
      this.description,
      this.id,
      this.mode,
      this.time,
      this.img});

  factory ExpenseModal.toModal(Map m) {
    return ExpenseModal(
        amount: m['amount'],
        category: m['category'],
        date: m['date'],
        description: m['description'],
        id: m['id'],
        mode: m['mode'],
        time: m['time'],
        img: m['img']);
  }

  factory ExpenseModal.fromMap({required Map<String, dynamic> map}) {
    return ExpenseModal(
        id: map['id'],
        amount: map['amount'],
        category: map['category'],
        date: map['date'],
        description: map['description'],
        img: map['img'],
        mode: map['mode'],
        time: map['time']);
  }
}
