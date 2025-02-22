import 'dart:developer';
import 'package:budget_tracker_app/modal/expense_modal.dart';
import 'package:budget_tracker_app/modal/income_modal.dart';
import 'package:budget_tracker_app/modal/recent_modal.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._();
  static DataBaseHelper dbh = DataBaseHelper._();
  Database? database;

  // Expense attributes

  String tName = "expense_table";
  String expenseId = "id";
  String expenseDesc = "description";
  String expenseAmt = "amount";
  String expenseCategory = "category";
  String expenseImage = "img";
  String expenseMode = "mode";
  String expenseDate = "date";
  String expenseTime = "time";

  // Income attributes
  String incomeTableName = "income_table";
  String incomeId = "id";
  String incomeDesc = "description";
  String incomeAmt = "amount";
  String incomeMode = "mode";
  String incomeDate = "date";
  String incomeTime = "time";

  //RECENT ATTRIBUTES
  String recentTransactionTableName = "recent_table";
  String recentId = "id";
  String recentType = "type";
  String recentTime = "time";
  String recentDate = "date";
  String recentMode = "mode";
  String recentAmt = "amount";
  String recentDesc = "description";

  // Methods

  Future<void> initDatabase() async {
    String path = await getDatabasesPath();
    String fpath = "${path}budget_app.db";
    database = await openDatabase(
      fpath,
      version: 1,
      onCreate: (db, version) async {
        //EXPENSE
        String q = '''CREATE TABLE $tName (
      $expenseId INTEGER PRIMARY KEY AUTOINCREMENT,
      $expenseDesc TEXT NOT NULL,
      $expenseAmt NUMERIC NOT NULL,
      $expenseCategory TEXT NOT NULL,
      $expenseMode TEXT NOT NULL,
      $expenseDate TEXT NOT NULL,
      $expenseTime TEXT NOT NULL,
      $expenseImage BLOB NOT NULL
      );''';

        await db.execute(q).then(
          (value) {
            log("created......");
          },
        ).onError(
          (error, _) {
            log("failed");
          },
        );

        //INCOME
        String q2 = '''CREATE TABLE $incomeTableName (
        $incomeId INTEGER PRIMARY KEY AUTOINCREMENT,
        $incomeDesc TEXT NOT NULL,
        $incomeAmt NUMERIC NOT NULL,
        $incomeDate TEXT NOT NULL,
        $incomeMode TEXT NOT NULL,
        $incomeTime TEXT NOT NULL
        )''';

        await db.execute(q2).then(
          (value) {
            log("created......");
          },
        ).onError(
          (error, _) {
            log("failed");
          },
        );

        //RECENT
        String q3 = '''CREATE TABLE $recentTransactionTableName (
        $recentId INTEGER PRIMARY KEY AUTOINCREMENT,
        $recentDesc TEXT NOT NULL,
        $recentAmt NUMERIC NOT NULL,
        $recentDate TEXT NOT NULL,
        $recentTime TEXT NOT NULL,
        $recentMode TEXT NOT NULL,
        $recentType TEXT NOT NULL
        )''';

        await db.execute(q3).then(
          (value) {
            log("created");
          },
        ).onError(
          (error, stackTrace) {
            log("failed");
          },
        );
      },
    );
  }

  Future<int?> insertExpense(ExpenseModal modal) async {
    await initDatabase();
    String q =
        "INSERT INTO $tName ($expenseDesc,$expenseAmt,$expenseCategory,$expenseMode,$expenseDate,$expenseTime,$expenseImage) VALUES (?, ?, ?, ?, ?, ?, ?);";

    List argument = [
      modal.description,
      modal.amount,
      modal.category,
      modal.mode,
      modal.date,
      modal.time,
      modal.img
    ];

    return await database?.rawInsert(q, argument);
  }

  Future<int?> insertIncome(IncomeModal modal) async {
    await initDatabase();
    String q2 =
        "INSERT INTO $incomeTableName ($incomeDesc,$incomeAmt,$incomeMode,$incomeDate,$incomeTime) VALUES (?, ?, ?, ?, ?);";

    List argument = [
      modal.description,
      modal.amount,
      modal.mode,
      modal.date,
      modal.time,
    ];

    return await database?.rawInsert(q2, argument);
  }

  Future<int?> insertRecentTransaction(RecentModal modal) async {
    await initDatabase();

    String q3 =
        "INSERT INTO $recentTransactionTableName ($recentDesc,$recentAmt,$recentDate,$recentTime,$recentMode,$recentType) VALUES (?, ?, ?, ?, ?, ?)";

    List argument = [
      modal.description,
      modal.amount,
      modal.date,
      modal.time,
      modal.mode,
      modal.type
    ];
    return await database?.rawInsert(q3, argument);
  }

  Future<List<RecentModal>> fetchRecentData() async {
    initDatabase();
    String q =
        "SELECT * FROM $recentTransactionTableName ORDER BY $recentId DESC";

    List<Map<String, dynamic>> res = await database?.rawQuery(q) ?? [];
    return res.map((e) => RecentModal.toModal(e)).toList();
  }

  Future<List<ExpenseModal>> fetchExpense() async {
    await initDatabase();

    String q = "SELECT * FROM $tName";

    List<Map<String, dynamic>> res = await database?.rawQuery(q) ?? [];
    return res.map((e) => ExpenseModal.toModal(e)).toList();
  }

  Future<List<IncomeModal>> fetchIncome() async {
    await initDatabase();

    String q = "SELECT * FROM $incomeTableName";

    List<Map<String, dynamic>> res = await database?.rawQuery(q) ?? [];
    return res.map((e) => IncomeModal.toModal(e)).toList();
  }

  // total expense pending
  Future<int?> updateExpense(ExpenseModal modal) async {
    if (database == null) await initDatabase();

    log("===========================");
    log("Updated Data: ${modal.description}");
    log("Updated Data: ${modal.amount}");
    log("Updated Data: ${modal.category}");
    log("Updated Data: ${modal.date}");
    log("Updated Data: ${modal.mode}");
    log("Updated Data: ${modal.time}");
    log("===========================");

    String q =
        "UPDATE $tName SET $expenseDesc = ?, $expenseAmt = ?, $expenseCategory = ?, $expenseDate = ?, $expenseImage = ?, $expenseMode = ?, $expenseTime = ? WHERE $expenseId = ${modal.id}";
    List v = [
      modal.description,
      modal.amount,
      modal.category,
      modal.date,
      modal.img,
      modal.mode,
      modal.time,
    ];

    return await database?.rawUpdate(q, v);
  }

  Future<int?> updateIncome(IncomeModal modal) async {
    if (database == null) await initDatabase();

    String? q =
        "UPDATE $incomeTableName SET $incomeDesc = ?, $incomeAmt = ?, $incomeMode = ?,$incomeDate = ?, $incomeTime = ? WHERE $incomeId = ${modal.id}";
    List l = [
      modal.description,
      modal.amount,
      modal.mode,
      modal.date,
      modal.time
    ];

    return await database?.rawUpdate(q, l);
  }

  Future<int?> deleteExpense(int id) async {
    if (database == null) await initDatabase();
    String q = "DELETE FROM $tName WHERE $expenseId = $id";
    return await database?.rawDelete(q);
  }

  Future<int?> deleteIncome(int id) async {
    if (database == null) await initDatabase();
    String q = "DELETE FROM $incomeTableName WHERE $incomeId = $id";
    return await database?.rawDelete(q);
  }

  Future<List<ExpenseModal>> searchCategory({required String search}) async {
    await initDatabase();
    String query =
        "SELECT * FROM $tName WHERE $expenseCategory LIKE '%$search%'";
    List<Map<String, dynamic>> result = await database?.rawQuery(query) ?? [];
    return result
        .map((Map<String, dynamic> e) => ExpenseModal.fromMap(map: e))
        .toList();
  }

  Future<int?> updateRecentTransaction(RecentModal modal)
  async {
    if (database == null) await initDatabase();
    String? q =
        "UPDATE $recentTransactionTableName SET $recentDesc = ?, $recentAmt = ?, $recentMode = ?,$recentDate = ?, $recentTime = ?, $recentType = ? WHERE $recentId = ${modal.id}";
    List l = [
      modal.description,
      modal.amount,
      modal.mode,
      modal.date,
      modal.time,
      modal.type
    ];

    return await database?.rawUpdate(q, l);
  }
}
