class ConfigData {
  final String apiKey;
  final String baseUrl;

  ConfigData({
    required this.apiKey,
    required this.baseUrl,
  });

  ConfigData.fromJson(Map<String, dynamic> json)
      : apiKey = json['apiKey'],
        baseUrl = json['baseUrl'];
}
