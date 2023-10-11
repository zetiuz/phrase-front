class Post {
  String userId = '';
  String imagen = '';
  String body = '';
  String createdAt = '';
  int thematic_id = 1;

  Post(
      { this.userId = '',
       this.imagen = '',
       this.body = '',
       this.createdAt = '',
       this.thematic_id = 1});

  factory Post.fromJson(Map<String, dynamic> responseData) {
    return Post(
        userId: responseData['User_id']?? '',
        imagen: responseData['Imagen']?? '',
        body: responseData['Body']?? '',
        createdAt: responseData['CreatedAt']?? '',
        thematic_id: responseData['Thematic_id']?? 1);
  }
}
