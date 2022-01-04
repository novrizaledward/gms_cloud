// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gms_cloud/core/utils/sharedpref.dart';
import 'package:gms_cloud/repository/request/modelLoginRequest.dart';
import 'package:gms_cloud/repository/request/ttbkReq.dart';
import 'package:gms_cloud/repository/respone/cobaimage.dart';
import 'package:gms_cloud/repository/respone/mdlDetailSuratJalanRespone.dart';
import 'package:gms_cloud/repository/respone/mdlSuratJalanRespone.dart';
import 'package:gms_cloud/repository/respone/modelBarang.dart';
import 'package:gms_cloud/repository/respone/modelLoginRespone.dart';
import 'package:gms_cloud/repository/respone/modelttbk.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiConstant {
  static const String BASE_URL = 'https://app2.gmscloud.id';
}

class ApiProvider {
  static Dio get _dio => Dio(
        BaseOptions(
          baseUrl: ApiConstant.BASE_URL,
          sendTimeout: 60000,
          contentType: 'application/json',
        ),
        // );
      )..interceptors.add(
          PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              error: true,
              compact: true,
              maxWidth: 300),
        );

  Future<LoginRespone?> login(LoginRequest loginRequest) async {
    try {
      Response response =
          await _dio.post('/login', data: loginRequest.toJson());
      var loginRespon = response.data;
      LoginRespone dataLogin = LoginRespone.fromJson(loginRespon);
      return dataLogin;
    } catch (e) {
      Exception(e);
    }
  }

  Future<SuratJalanRespone?> suratJalan() async {
    var data = await StorageManager.getLoginModel();
    try {
      Response response = await _dio.post('/surat_jalan', data: data);
      var suratJalanRes = response.data;
      SuratJalanRespone dataSuratJalan =
          SuratJalanRespone.fromJson(suratJalanRes);
      return dataSuratJalan;
    } catch (e) {
      Exception(e);
    }
  }

  Future<ModelDetailSuratJalanRespone?> detailSuratJalan(
      String? idSuratJalan) async {
    try {
      Response response =
          await _dio.get('/surat_jalan/detail/id/$idSuratJalan');
      var detailSuratJalanRes = response.data;
      ModelDetailSuratJalanRespone dataDetailSuratJalan =
          ModelDetailSuratJalanRespone.fromJson(detailSuratJalanRes);
      return dataDetailSuratJalan;
    } catch (e) {
      Exception(e);
    }
  }

  Future<ModelBarang?> detailBarang() async {
    var data = await StorageManager.getLoginModel();

    try {
      Response response = await _dio.post('/barang', data: data);

      var detailBarangRes = response.data;
      ModelBarang dataDetailBarang = ModelBarang.fromJson(detailBarangRes);
      return dataDetailBarang;
    } catch (e) {
      Exception(e);
    }
  }

  Future<ModelTtbkRespone?> ttbk(
    String idSuratJalan,
    String filePath,
    List<String> listTtbk,
  ) async {
    FormData formData = FormData.fromMap({
      'id_surat_jalan': idSuratJalan,
      'file': await MultipartFile.fromFile(
        filePath,
      ),
      'ttbk[]': listTtbk
    });

    try {
      Response response = await _dio.post(
        '/ttbk2',
        data: formData,
      );

      var ttbkRes = response.data;

      ModelTtbkRespone dataTtbk = ModelTtbkRespone.fromJson(ttbkRes);
      return dataTtbk;
    } catch (e) {
      Exception(e);
    }
  }
}
