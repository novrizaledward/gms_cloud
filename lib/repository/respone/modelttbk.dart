class TtbkModel {
  String? jenisBarang;
  final String? jmlMP;
  final String? jmlMR;
  String? isiKosong;

  TtbkModel(this.jmlMP, this.jmlMR, this.jenisBarang, this.isiKosong);
}

class ModelTtbkRespone {
  bool? status;
  String? idSuratJalan;
  String? file;
  List<Ttbk>? ttbk;

  ModelTtbkRespone({this.status, this.idSuratJalan, this.file, this.ttbk});

  ModelTtbkRespone.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    idSuratJalan = json['id_surat_jalan'];
    file = json['file'];
    if (json['ttbk'] != null) {
      ttbk = <Ttbk>[];
      json['ttbk'].forEach((v) {
        ttbk!.add(Ttbk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['id_surat_jalan'] = idSuratJalan;
    data['file'] = file;
    if (ttbk != null) {
      data['ttbk'] = ttbk!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ttbk {
  String? idBarang;
  String? mp;
  String? mr;
  String? isiKosong;

  Ttbk({this.idBarang, this.mp, this.mr, this.isiKosong});

  Ttbk.fromJson(Map<String, dynamic> json) {
    idBarang = json['id_barang'];
    mp = json['mp'];
    mr = json['mr'];
    isiKosong = json['isi_kosong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_barang'] = idBarang;
    data['mp'] = mp;
    data['mr'] = mr;
    data['isi_kosong'] = isiKosong;
    return data;
  }
}
