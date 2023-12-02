import 'dart:convert';

import '../../domain/entities/book_entity.dart';

class BookDTO extends BookEntity {
  const BookDTO({
    bool? isFavorite,
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.downloadUrl,
  }) : super(isFavorite: isFavorite ?? false);

  factory BookDTO.fromEntity(BookEntity bookEntity) {
    return BookDTO(
      id: bookEntity.id,
      title: bookEntity.title,
      author: bookEntity.author,
      coverUrl: bookEntity.coverUrl,
      downloadUrl: bookEntity.downloadUrl,
      isFavorite: bookEntity.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'downloadUrl': downloadUrl,
      'isFavorite': isFavorite,
    };
  }

  Map<String, dynamic> toSQLMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'downloadUrl': downloadUrl,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory BookDTO.fromSQLMap(Map<String, dynamic> map) {
    return BookDTO(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      coverUrl: map['coverUrl'] as String,
      downloadUrl: map['downloadUrl'] as String,
      isFavorite: (map['isFavorite'] as int) == 1 ? true : false,
    );
  }

  factory BookDTO.fromMap(Map<String, dynamic> map) {
    return BookDTO(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      coverUrl: map['cover_url'] as String,
      downloadUrl: map['download_url'] as String,
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookDTO.fromJson(String source) =>
      BookDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  BookDTO copyWith(
      {int? id,
      String? title,
      String? author,
      String? coverUrl,
      String? downloadUrl,
      bool? isFavorite}) {
    return BookDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
