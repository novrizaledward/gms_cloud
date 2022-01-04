// ignore_for_file: file_names

class ModelBarang {
  bool? status;
  List<Data>? data;

  ModelBarang({this.status, this.data});

  ModelBarang.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? mASTERBARANGID;
  String? mASTERBARANGNAMA;

  Data({this.mASTERBARANGID, this.mASTERBARANGNAMA});

  Data.fromJson(Map<String, dynamic> json) {
    mASTERBARANGID = json['MASTER_BARANG_ID'];
    mASTERBARANGNAMA = json['MASTER_BARANG_NAMA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MASTER_BARANG_ID'] = mASTERBARANGID;
    data['MASTER_BARANG_NAMA'] = mASTERBARANGNAMA;
    return data;
  }
}
