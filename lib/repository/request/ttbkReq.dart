// ignore_for_file: file_names

class TtbkReq {
  String? idSuratJalan;
  String? file;
  List<String>? ttbk;

  TtbkReq({this.idSuratJalan, this.file, this.ttbk});

  TtbkReq.fromJson(Map<String, dynamic> json) {
    idSuratJalan = json['id_surat_jalan'];
    file = json['file'];
    ttbk = json['ttbk'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id_surat_jalan'] = idSuratJalan;
    data['file'] = file;
    data['ttbk'] = ttbk;
    return data;
  }
}
