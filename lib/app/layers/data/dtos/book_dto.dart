import 'dart:convert';

import '../../domain/entities/book_entity.dart';

class BookDTO extends BookEntity {
  const BookDTO({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.downloadUrl,
    bool? isFavorite,
  }) : super(isFavorite: isFavorite ?? false);

  factory BookDTO.fromSQLMap(Map<String, dynamic> map) => BookDTO(
        id: map['id'] as int,
        title: map['title'] as String,
        author: map['author'] as String,
        coverUrl: map['coverUrl'] as String,
        downloadUrl: map['downloadUrl'] as String,
        isFavorite: (map['isFavorite'] as int) == 1,
      );

  factory BookDTO.fromMap(Map<String, dynamic> map) {
    final authors = map['authors'] as List<dynamic>?;

    return BookDTO(
      id: map['id'] as int,
      title: map['title'] as String,
      author: authors != null && authors.isNotEmpty
          ? authors[0]['name'] as String
          : 'Unknown',
      coverUrl: map['formats']?['image/jpeg'] as String? ?? '',
      downloadUrl: map['formats']?['application/epub+zip'] as String? ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  factory BookDTO.fromJson(String source) =>
      BookDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  factory BookDTO.fromEntity(BookEntity bookEntity) => BookDTO(
        id: bookEntity.id,
        title: bookEntity.title,
        author: bookEntity.author,
        coverUrl: bookEntity.coverUrl,
        downloadUrl: bookEntity.downloadUrl,
        isFavorite: bookEntity.isFavorite,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'downloadUrl': downloadUrl,
        'isFavorite': isFavorite,
      };

  Map<String, dynamic> toSQLMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'downloadUrl': downloadUrl,
        'isFavorite': isFavorite ? 1 : 0,
      };

  String toJson() => json.encode(toMap());

  BookDTO copyWith({
    int? id,
    String? title,
    String? author,
    String? coverUrl,
    String? downloadUrl,
    bool? isFavorite,
  }) =>
      BookDTO(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        coverUrl: coverUrl ?? this.coverUrl,
        downloadUrl: downloadUrl ?? this.downloadUrl,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
