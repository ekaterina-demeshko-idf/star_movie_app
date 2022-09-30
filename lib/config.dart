class FlavorConfig {
  final String appTitle;
  final String apiKey;
  final String baseUrl;

  FlavorConfig({
    required this.appTitle,
    required this.apiKey,
    required this.baseUrl,
  });

  FlavorConfig.fromJson(Map<String, dynamic> json)
      : appTitle = json['appTitle'],
        apiKey = json['apiKey'],
        baseUrl = json['baseUrl'];
}
