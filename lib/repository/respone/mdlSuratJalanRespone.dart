// ignore_for_file: file_names, unnecessary_new
class SuratJalanRespone {
  bool? status;
  List<Data>? data;

  SuratJalanRespone({this.status, this.data});

  SuratJalanRespone.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
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
  String? sURATJALANID;
  String? sURATJALANNOMOR;
  String? sURATJALANTANGGAL;
  String? eNTRIWAKTU;
  String? mASTERRELASIID;
  String? mASTERSUPPLIERID;
  String? sURATJALANJENIS;
  String? tANGGAL;
  String? jAM;
  String? jENIS;
  String? nAMA;

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
      this.jENIS,
      this.nAMA});

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
    jENIS = json['JENIS'];
    nAMA = json['NAMA'];
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
    data['JENIS'] = jENIS;
    data['NAMA'] = nAMA;
    return data;
  }
}
