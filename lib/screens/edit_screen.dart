import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final Transactions statement;

  const EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final speciesController = TextEditingController();
  final healthController = TextEditingController();
  final habitatController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ตั้งค่า initial value สำหรับ TextEditingController
    titleController.text = widget.statement.title;
    speciesController.text = widget.statement.species;
    healthController.text = widget.statement.health;
    habitatController.text = widget.statement.habitat;
    ageController.text = widget.statement.age.toString();

    // ตั้ง listener บน speciesController
    speciesController.addListener(() {
      var provider = Provider.of<TransactionProvider>(context, listen: false);
      habitatController.text = provider.getHabitatBySpecies(speciesController.text);
    });
  }

  @override
  void dispose() {
    // ปล่อย resource ของ TextEditingControllers
    titleController.dispose();
    speciesController.dispose();
    healthController.dispose();
    habitatController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ชื่อสัตว์',
              ),
              autofocus: false,
              controller: titleController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'สายพันธุ์',
              ),
              autofocus: false,
              controller: speciesController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'สุขภาพ',
              ),
              autofocus: false,
              controller: healthController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'อายุ',
              ),
              keyboardType: TextInputType.number,
              controller: ageController,
              validator: (String? input) {
                if (input == null || input.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                try {
                  int age = int.parse(input);
                  if (age <= 0) {
                    return 'กรุณากรอกข้อมูลมากกว่า 0';
                  }
                } catch (e) {
                  return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'ถิ่นอาศัย'),
              autofocus: false,
              controller: habitatController,
              readOnly: true, // ตั้งค่าให้ไม่สามารถกรอกได้
            ),
            TextButton(
              child: const Text('แก้ไขข้อมูล'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // create transaction data object
                  var statement = Transactions(
                    keyID: widget.statement.keyID,
                    title: titleController.text,
                    species: speciesController.text,
                    health: healthController.text,
                    habitat: habitatController.text,
                    age: int.parse(ageController.text),
                    date: DateTime.now(),
                  );

                  // update transaction data object in provider
                  var provider = Provider.of<TransactionProvider>(context, listen: false);
                  provider.updateTransaction(statement);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return const MyHomePage();
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
