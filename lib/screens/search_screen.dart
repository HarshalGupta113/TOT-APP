import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';
import '../providers/dog_provider.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final dogProvider = Provider.of<DogProvider>(context);

    // Show filtered results only when query is not empty
    final List<Dog> filteredDogs = query.isEmpty
        ? [] // Empty list when no search query
        : dogProvider.dogs
            .where((dog) =>
                dog.name.toLowerCase().contains(query.toLowerCase()) ||
                (dog.breedGroup?.toLowerCase() ?? "")
                    .contains(query.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Search Dogs")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Search by name or breed",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: query.isEmpty
                ? const Center(
                    child: Text(
                        "Enter a search term")) // Show this when search is empty
                : filteredDogs.isEmpty
                    ? const Center(child: Text("No results found"))
                    : ListView.builder(
                        itemCount: filteredDogs.length,
                        itemBuilder: (context, index) {
                          final dog = filteredDogs[index];
                          return ListTile(
                            leading: dog.image != null && dog.image!.isNotEmpty
                                ? Image.network(dog.image!,
                                    width: 50, height: 50, fit: BoxFit.cover)
                                : const Icon(Icons.pets,
                                    size: 50,
                                    color: Colors
                                        .grey), // Default icon if no image
                            title: Text(dog.name),
                            subtitle: Text(dog.breedGroup ?? "Unknown Breed"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(dog: dog),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
