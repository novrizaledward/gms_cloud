// ignore_for_file: file_names

class ModelDetailSuratJalanRespone {
  bool? status;
  List<Data>? data;

  ModelDetailSuratJalanRespone({this.status, this.data});

  ModelDetailSuratJalanRespone.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sURATJALANID;
  String? sURATJALANNOMOR;
  String? sURATJALANTANGGAL;
  String? eNTRIWAKTU;
  String? mASTERRELASIID;
  String? mASTERSUPPLIERID;
  String? sURATJALANJENIS;
  String? tANGGAL;
  String? jAM;
  String? nAMA;
  List<BARANG>? bARANG;

  Data(
      {this.sURATJALANID,
      this.sURATJALANNOMOR,
      this.sURATJALANTANGGAL,
      this.eNTRIWAKTU,
      this.mASTERRELASIID,
      this.mASTERSUPPLIERID,
      this.sURATJALANJENIS,
      this.tANGGAL,
      this.jAM,
      this.nAMA,
      this.bARANG});

  Data.fromJson(Map<String, dynamic> json) {
    sURATJALANID = json['SURAT_JALAN_ID'];
    sURATJALANNOMOR = json['SURAT_JALAN_NOMOR'];
    sURATJALANTANGGAL = json['SURAT_JALAN_TANGGAL'];
    eNTRIWAKTU = json['ENTRI_WAKTU'];
    mASTERRELASIID = json['MASTER_RELASI_ID'];
    mASTERSUPPLIERID = json['MASTER_SUPPLIER_ID'];
    sURATJALANJENIS = json['SURAT_JALAN_JENIS'];
    tANGGAL = json['TANGGAL'];
    jAM = json['JAM'];
    nAMA = json['NAMA'];
    if (json['BARANG'] != null) {
      bARANG = <BARANG>[];
      json['BARANG'].forEach((v) {
        bARANG?.add(BARANG.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SURAT_JALAN_ID'] = sURATJALANID;
    data['SURAT_JALAN_NOMOR'] = sURATJALANNOMOR;
    data['SURAT_JALAN_TANGGAL'] = sURATJALANTANGGAL;
    data['ENTRI_WAKTU'] = eNTRIWAKTU;
    data['MASTER_RELASI_ID'] = mASTERRELASIID;
    data['MASTER_SUPPLIER_ID'] = mASTERSUPPLIERID;
    data['SURAT_JALAN_JENIS'] = sURATJALANJENIS;
    data['TANGGAL'] = tANGGAL;
    data['JAM'] = jAM;
    data['NAMA'] = nAMA;
    if (bARANG != null) {
      data['BARANG'] = bARANG?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BARANG {
  String? mASTERBARANGNAMA;
  String? sURATJALANBARANGQUANTITY;
  String? sURATJALANBARANGQUANTITYKOSONG;

  BARANG(
      {this.mASTERBARANGNAMA,
      this.sURATJALANBARANGQUANTITY,
      this.sURATJALANBARANGQUANTITYKOSONG});

  BARANG.fromJson(Map<String, dynamic> json) {
    mASTERBARANGNAMA = json['MASTER_BARANG_NAMA'];
    sURATJALANBARANGQUANTITY = json['SURAT_JALAN_BARANG_QUANTITY'];
    sURATJALANBARANGQUANTITYKOSONG = json['SURAT_JALAN_BARANG_QUANTITY_KOSONG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MASTER_BARANG_NAMA'] = mASTERBARANGNAMA;
    data['SURAT_JALAN_BARANG_QUANTITY'] = sURATJALANBARANGQUANTITY;
    data['SURAT_JALAN_BARANG_QUANTITY_KOSONG'] = sURATJALANBARANGQUANTITYKOSONG;
    return data;
  }
}
