class Dog {
  final int id;
  final String name;
  final String? image; // Nullable if missing in API
  final String? breedGroup;
  final String? description;

  Dog({
    required this.id,
    required this.name,
    this.image,
    this.breedGroup,
    this.description,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      image: json['image'] as String?, // Use nullable conversion
      breedGroup: json['breed_group'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'breed_group': breedGroup,
      'description': description,
    };
  }
}
