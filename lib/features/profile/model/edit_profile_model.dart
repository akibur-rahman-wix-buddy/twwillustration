import 'dart:io';

class EditProfileModel {
  final File? profileImage;
  final String? bio;
  final String? firstName;
  final String? lastName;
  final String? location;
  final String? email;

  const EditProfileModel({
      this.profileImage,
      this.bio, 
      this.firstName, 
      this.lastName, 
      this.location, 
      this.email
      });
}
