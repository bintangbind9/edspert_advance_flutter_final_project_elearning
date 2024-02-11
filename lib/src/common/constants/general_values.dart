class GeneralValues {
  static const String majorName = 'IPA';
  static const int maxHomeCourseCount = 3;
  static const int maxHomeBannerCount = 5;
  static const String defaultAnswer = 'X';
  static const String genderM = 'Laki-Laki';
  static const String genderF = 'Perempuan';
  static const String defaultJenjang = 'SMA';
  static const String defaultPhotoURL = 'url_foto';
  static const String testingEmail = 'testerngbayu@gmail.com';
  static const List<String> schoolGrades = ['10', '11', '12'];
  static const Map<StoragePath, String> storagePath = {
    StoragePath.profilePict: "profile_pictures",
    StoragePath.chatImage: "chat_images",
  };
}

enum StoragePath {
  profilePict,
  chatImage,
}
