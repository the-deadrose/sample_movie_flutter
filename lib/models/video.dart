class Video{


  final String name;
  final String key;

  Video({required this.key, required this.name});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
        key: json['key'] ?? '',
        name: json['name'] ?? ''
    );

  }
}