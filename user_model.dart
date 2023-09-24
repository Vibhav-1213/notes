class UserModel {
  final String? id;
  final String title;
  final String Content;

  const UserModel({
    this.id,
    required this.title,
    required this.Content,
  });

  toJson(){
    return {
      "Title": title,
      "Content": Content,
    };
  }

}