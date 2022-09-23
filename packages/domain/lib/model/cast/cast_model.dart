import 'package:json_annotation/json_annotation.dart';
import 'cast.dart';

part 'cast_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CastModel {
  List<Cast>? cast;

  CastModel({
    this.cast,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) =>
      _$CastModelFromJson(json);

  Map<String, dynamic> toJson() => _$CastModelToJson(this);
}
