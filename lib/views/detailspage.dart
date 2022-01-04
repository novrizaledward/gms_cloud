// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gms_cloud/core/bloc/detail_suratJalan_bloc/detail_suratjalan_bloc.dart';
import 'package:gms_cloud/views/ttbk.dart';
import 'package:gms_cloud/widget/widget.dart';

class DetailPage extends StatefulWidget {
  final String? nomorSuratJalanId;
  final String? nama;
  final String? suratJalanNomor;
  const DetailPage({
    Key? key,
    this.nomorSuratJalanId,
    this.nama,
    this.suratJalanNomor,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? suratJalanId;
  @override
  void initState() {
    DetailSuratjalanBloc detailSuratJalanBloc =
        BlocProvider.of<DetailSuratjalanBloc>(context, listen: false);
    detailSuratJalanBloc.add(DetailSuratJalanAksi(widget.nomorSuratJalanId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.nama!,
                  style: TextStyle(color: Color(0xffA7A7A7), fontSize: 16),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.people,
                  color: Color(0xffA7A7A7),
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          BlocListener<DetailSuratjalanBloc, DetailSuratjalanState>(
            listener: (context, state) {
              if (state is DetailSuratJalanLoaded) {
                suratJalanId = state
                    .modelDetailSuratJalanRespone?.data?[0].sURATJALANID
                    .toString();
              }
            },
            child: BlocBuilder<DetailSuratjalanBloc, DetailSuratjalanState>(
              builder: (context, state) {
                if (state is DetailSuratJalanWaiting) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff029C40)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (state is DetailSuratJalanError) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(child: Text("Detail tidak Ditemukan")),
                      ),
                    ),
                  );
                }
                if (state is DetailSuratJalanLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GMScardDetail(
                        nomorSuratJalan: state.modelDetailSuratJalanRespone
                            ?.data?[0].sURATJALANNOMOR,
                        relasiNama:
                            state.modelDetailSuratJalanRespone?.data?[0].nAMA,
                        tanggal: state
                            .modelDetailSuratJalanRespone?.data?[0].tANGGAL,
                        jam: state.modelDetailSuratJalanRespone?.data?[0].jAM,
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text('Barang', style: TextStyle(fontSize: 18)),
                      ),
                      Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.modelDetailSuratJalanRespone
                                ?.data?[0].bARANG?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(state
                                      .modelDetailSuratJalanRespone!
                                      .data![0]
                                      .bARANG![index]
                                      .mASTERBARANGNAMA!),
                                  Row(
                                    children: [
                                      Text(state
                                          .modelDetailSuratJalanRespone!
                                          .data![0]
                                          .bARANG![index]
                                          .sURATJALANBARANGQUANTITY!),
                                      Text(' - '),
                                      Text(state
                                          .modelDetailSuratJalanRespone!
                                          .data![0]
                                          .bARANG![index]
                                          .sURATJALANBARANGQUANTITYKOSONG!),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ttbk(
                            nama: widget.nama,
                            nomorSuratJalan: widget.suratJalanNomor,
                            suratJalanId: suratJalanId,
                          )));
            },
            child: Text("TTBK"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xff029C40),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 35)),
            ),
          ),
        ],
      ),
    );
  }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }
}
