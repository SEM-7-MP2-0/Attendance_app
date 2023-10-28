class FaceCountModel {
  final int faceCount;
  final String image;
  final String message;

  FaceCountModel({
    required this.faceCount,
    required this.image,
    required this.message,
  });

  factory FaceCountModel.fromJson(Map<String, dynamic> json) {
    return FaceCountModel(
      faceCount: json['face_count'],
      image: 'http://104.198.196.196:5002/' + json['image'],
      message: json['message'],
    );
  }
}
