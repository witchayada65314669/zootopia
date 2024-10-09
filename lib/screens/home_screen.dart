import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("zootopia 🐼"),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              color: Colors.white,
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget? child) {
            if (provider.transactions.isEmpty) {
              return const Center(
                child: Text('ไม่มีรายการ'),
              );
            } else {
              return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, index) {
                  var statement = provider.transactions[index];
                  String species = statement.species;
                  String animalEmoji = provider.getAnimalEmoji(species);
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: ListTile(
                      title: Text(
                        statement.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        // ใช้ Column เพื่อแสดง health เหนือวันที่
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'species: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '${statement.species}'),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'age: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '${statement.age}'),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'habitat: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '${statement.habitat}'),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'health: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '${statement.health}'),
                              ],
                            ),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy hh:mm:ss')
                                .format(statement.date),
                          ), // แสดงวันที่
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(
                            animalEmoji,
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.deleteTransaction(statement.keyID);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditScreen(statement: statement);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
