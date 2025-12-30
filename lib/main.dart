import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const AnimalSoundApp());
}

class AnimalSoundApp extends StatefulWidget {
  const AnimalSoundApp({super.key});

  @override
  State<AnimalSoundApp> createState() => _AnimalSoundAppState();
}

class _AnimalSoundAppState extends State<AnimalSoundApp> {
  final AudioPlayer player = AudioPlayer();

  final List<String> animals = [
    'dog',
    'cat',
    'cow',
    'horse',
    'birds',
  ];

  String currentAnimal = 'dog';

  @override
  void initState() {
    super.initState();
    generateRandomAnimal();
  }

  void generateRandomAnimal() {
    final random = Random();
    setState(() {
      currentAnimal = animals[random.nextInt(animals.length)];
    });
  }

  void playSound(String animal) {
    player.play(AssetSource('audio/$animal.wav'));
  }

  Widget buildAnimalButton(String animal, String emoji) {
    return ElevatedButton(
      onPressed: () {
        if (animal == currentAnimal) {
          playSound(animal);
          generateRandomAnimal();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        minimumSize: const Size(120, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 4),
          Text(
            animal.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Animal Sound App'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Instruction
              const Text(
                'Tap the correct animal',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),

              //Target Animal
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  currentAnimal.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Animal Buttons
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    buildAnimalButton('dog','🐶' ),
                    buildAnimalButton('cat', '🐈'),
                    buildAnimalButton('cow', '🐮'),
                    buildAnimalButton('horse','🐎'),
                    buildAnimalButton('birds','🕊️'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
