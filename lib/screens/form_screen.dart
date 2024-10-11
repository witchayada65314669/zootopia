import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final speciesController = TextEditingController();
  final healthController = TextEditingController();
  final habitatController = TextEditingController();
  final ageController = TextEditingController();

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    super.initState();

    // ตั้ง listener บน speciesController
    widget.speciesController.addListener(() {
      // เรียกใช้ฟังก์ชันจาก provider
      var provider = Provider.of<TransactionProvider>(context, listen: false);
      widget.habitatController.text = provider.getHabitatBySpecies(widget.speciesController.text);
    });
  }

  @override
  void dispose() {
    // ปล่อย resource ของ TextEditingControllers
    widget.titleController.dispose();
    widget.speciesController.dispose();
    widget.healthController.dispose();
    widget.habitatController.dispose();
    widget.ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มข้อมูล'),
      ),
      body: Form(
        key: widget.formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ชื่อสัตว์',
              ),
              controller: widget.titleController,
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
              controller: widget.speciesController,
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
              controller: widget.healthController,
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
              controller: widget.ageController,
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
              controller: widget.habitatController,
              readOnly: true,
            ),
            TextButton(
              child: const Text('บันทึก'),
              onPressed: () {
                if (widget.formKey.currentState!.validate()) {
                  // create transaction data object
                  var statement = Transactions(
                    keyID: null,
                    title: widget.titleController.text,
                    species: widget.speciesController.text,
                    health: widget.healthController.text,
                    habitat: widget.habitatController.text,
                    age: int.parse(widget.ageController.text),
                    date: DateTime.now(),
                  );

                  // add transaction data object to provider
                  var provider = Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(statement);

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