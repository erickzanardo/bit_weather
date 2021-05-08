import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  Location({
    required this.title,
    required this.whoid,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return _$LocationFromJson(json);
  }

  final String title;
  final int whoid;

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  List<Object?> get props => [title, whoid];
}
