class Transactions {
  final int? keyID;
  final String title;
  final int age;
  final DateTime date;
  final String species;
  final String health;
  final String habitat;

  Transactions({
    this.keyID,
    required this.title,
    required this.age,
    required this.date,
    required this.species,
    required this.health,
    required this.habitat
  });
}