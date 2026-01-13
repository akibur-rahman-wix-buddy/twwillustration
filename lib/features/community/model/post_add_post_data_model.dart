import 'package:image_picker/image_picker.dart';

class PostAddPostDataModel {
  final String caption;
  final XFile image;
  final List tags;
  final String visibility;

  const PostAddPostDataModel({required this.caption, required this.image, required this.tags, required this.visibility});

}