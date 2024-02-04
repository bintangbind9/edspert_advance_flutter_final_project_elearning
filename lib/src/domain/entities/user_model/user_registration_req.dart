class UserRegistrationReq {
  final String namaLengkap;
  final String email;
  final String namaSekolah;
  final String kelas;
  final String gender;
  final String jenjang;
  final String? foto;

  UserRegistrationReq({
    required this.namaLengkap,
    required this.email,
    required this.namaSekolah,
    required this.kelas,
    required this.gender,
    required this.jenjang,
    this.foto,
  });

  factory UserRegistrationReq.fromJson(Map<String, dynamic> json) =>
      UserRegistrationReq(
        namaLengkap: json["nama_lengkap"],
        email: json["email"],
        namaSekolah: json["nama_sekolah"],
        kelas: json["kelas"],
        gender: json["gender"],
        foto: json["foto"],
        jenjang: json["jenjang"],
      );

  Map<String, dynamic> toJson() => {
        "nama_lengkap": namaLengkap,
        "email": email,
        "nama_sekolah": namaSekolah,
        "kelas": kelas,
        "gender": gender,
        "foto": foto,
        "jenjang": jenjang,
      };
}
