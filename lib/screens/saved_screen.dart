import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';
import '../providers/dog_provider.dart';
import 'detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dogProvider = Provider.of<DogProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Saved Dogs")),
      body: dogProvider.savedDogs.isEmpty
          ? const Center(
              child: Text(
                "No saved dogs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: dogProvider.savedDogs.length,
              itemBuilder: (context, index) {
                final Dog dog = dogProvider.savedDogs[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: dog.image != null && dog.image!.isNotEmpty
                          ? Image.network(
                              dog.image!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.pets,
                              size: 50, color: Colors.grey), // Default icon
                    ),
                    title: Text(
                      dog.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      dog.breedGroup ?? "Unknown Breed",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        dogProvider.removeDog(dog.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Dog removed from saved list"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(dog: dog),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
