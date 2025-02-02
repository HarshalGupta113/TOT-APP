import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';
import '../providers/dog_provider.dart';

class DetailScreen extends StatelessWidget {
  final Dog dog;

  const DetailScreen({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    final dogProvider = Provider.of<DogProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(dog.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: dog.image != null && dog.image!.isNotEmpty
                    ? Image.network(
                        dog.image!,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.pets,
                        size: 150,
                        color: Colors.grey), // Placeholder if no image
              ),
              const SizedBox(height: 20),
              Text(
                dog.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                dog.breedGroup ?? "Unknown Breed Group",
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                dog.description ?? "No description available",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  dogProvider.saveDog(dog);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Dog saved successfully!"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.favorite),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
