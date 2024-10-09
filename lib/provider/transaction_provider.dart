import 'package:account/databases/transaction_db.dart';
import 'package:flutter/foundation.dart';
import 'package:account/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbName: 'transactions.db');
    transactions = await db.loadAllData();
    print(transactions);
    notifyListeners();
  }

  void addTransaction(Transactions transaction) async {
    var db = TransactionDB(dbName: 'transactions.db');
    var keyID = await db.insertDatabase(transaction);
    transactions = await db.loadAllData();
    print(transactions);
    notifyListeners();
  }

  void deleteTransaction(int? index) async {
    print('delete index: $index');
    var db = TransactionDB(dbName: 'transactions.db');
    await db.deleteDatabase(index);
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void updateTransaction(Transactions transaction) async {
    var db = TransactionDB(dbName: 'transactions.db');
    await db.updateDatabase(transaction);
    transactions = await db.loadAllData();
    notifyListeners();
  }

  String getAnimalEmoji(String species) {
    switch (species) {
      case 'elephant':
        return '🐘';
      case 'fox':
        return '🦊';
      case 'rabbit':
        return '🐰';
      case 'peacock':
        return '🦚';
      case 'sloth':
        return '🦥';
      case 'raccoon':
        return '🦝';
      case 'rhino':
        return '🦏';
      case 'zebra':
        return '🦓';
      case 'chipmunk':
        return '🐿️';
      case 'parrot':
        return '🦜';
      case 'llama':
        return '🦙';
      case 'sheep':
        return '🐑';
      case 'kangaroo':
        return '🦘';
      case 'monkey':
        return '🐵';
      case 'lion':
        return '🦁';
      case 'orangutan':
        return '🦧';
      case 'hippopotamus':
        return '🦛';
      case 'tiger':
        return '🐯';
      case 'koala':
        return '🐨';
      case 'panda':
        return '🐼';
      default:
        return '🐾'; // อิโมจิเริ่มต้นหากไม่ตรงกับเงื่อนไข
    }
  }

   String getHabitatBySpecies(String species) {
    // กำหนดถิ่นอาศัยตามสายพันธุ์
    switch (species.toLowerCase()) {
      case 'elephant':
        return '🐘';
      case 'fox':
        return 'Forests, grasslands, mountains, and deserts';
      case 'rabbit':
        return 'Meadows, forests, grasslands, and wetlands';
      case 'peacock':
        return 'Forests, grasslands, and near water sources in South Asia';
      case 'sloth':
        return 'Tropical rainforests in Central and South America';
      case 'raccoon':
        return 'Forests, urban areas, and wetlands in North America';
      case 'rhino':
        return 'Savannas, grasslands, and forests in Africa and South Asia';
      case 'zebra':
        return 'Grasslands and savannas in Africa';
      case 'chipmunk':
        return 'Forests, woodlands, and gardens in North America';
      case 'parrot':
        return 'Tropical and subtropical regions worldwide, including rainforests';
      case 'llama':
        return 'Andes mountains in South America';
      case 'sheep':
        return 'Grasslands, mountains, and farms worldwide';
      case 'kangaroo':
        return 'Grasslands, forests, and scrublands in Australia';
      case 'monkey':
        return 'Forests, savannas, and mountains worldwide, especially in tropical regions';
      case 'lion':
        return 'Savannas and grasslands in Africa and parts of Asia';
      case 'orangutan':
        return 'Rainforests in Borneo and Sumatra';
      case 'hippopotamus':
        return 'Rivers, lakes, and wetlands in Africa';
      case 'tiger':
        return 'Forests, grasslands, and wetlands in Asia';
      case 'koala':
        return 'Eucalyptus forests in Australia';
      case 'panda':
        return 'Mountainous regions of China, particularly in bamboo forests';
      default:
        return 'unknown'; // ถ้าสายพันธุ์ไม่อยู่ในรายการ
    }
  }
}
