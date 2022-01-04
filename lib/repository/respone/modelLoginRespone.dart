// ignore_for_file: file_names

class LoginRespone {
  late bool status;
  late Data data;

  LoginRespone({required this.status, required this.data});

  LoginRespone.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  late String id;
  late String perusahaan;
  late String nama;

  Data({required this.id, required this.perusahaan, required this.nama});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    perusahaan = json['perusahaan'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['perusahaan'] = perusahaan;
    data['nama'] = nama;
    return data;
  }
}
