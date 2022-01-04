// ignore_for_file: file_names

class SuratJalanRequest {
  String? id;
  String? perusahaan;

  SuratJalanRequest({this.id, this.perusahaan});

  SuratJalanRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    perusahaan = json['perusahaan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['perusahaan'] = perusahaan;
    return data;
  }
}
