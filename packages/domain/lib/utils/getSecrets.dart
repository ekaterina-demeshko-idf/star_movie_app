import "package:flutter/services.dart" as s;
import "package:yaml/yaml.dart";

Future<YamlMap> getSecrets() async {
  final data = await s.rootBundle.loadString('secrets.yaml');
  final mapData = loadYaml(data);
  print('GET SECRETS $mapData');
  return mapData;
}