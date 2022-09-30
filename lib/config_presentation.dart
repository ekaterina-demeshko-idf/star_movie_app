class ConfigPresentation {
  final String appTitle;

  ConfigPresentation({required this.appTitle});

  ConfigPresentation.fromJson(Map<String, dynamic> json)
      : appTitle = json['appTitle'];

}
