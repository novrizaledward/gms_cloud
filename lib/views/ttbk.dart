// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gms_cloud/core/bloc/barang_bloc/barang_bloc.dart';
import 'package:gms_cloud/core/bloc/ttbk_bloc/ttbk_bloc.dart';
import 'package:gms_cloud/repository/respone/modelttbk.dart';
import 'package:gms_cloud/views/homepage.dart';
import 'package:gms_cloud/widget/widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class Ttbk extends StatefulWidget {
  final String? nama;
  final String? nomorSuratJalan;
  final String? suratJalanId;
  const Ttbk({Key? key, this.nama, this.nomorSuratJalan, this.suratJalanId})
      : super(key: key);

  @override
  _TtbkState createState() => _TtbkState();
}

class _TtbkState extends State<Ttbk> {
  final TextEditingController _controllerMP = TextEditingController();
  final TextEditingController _controllerMR = TextEditingController();
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  final List<TtbkModel> itemBarangBaru = [];
  List<String> itemList = [];
  String? _valBarang;
  String? _isiKosong;
  @override
  void initState() {
    super.initState();
    BarangBloc barangBloc = BlocProvider.of<BarangBloc>(context, listen: false);
    barangBloc.add(BarangAksi());
  }

  alert(String filePath) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("Anda Yakin ?"),
              content: Text("Silahkan periksa kembali data anda !"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Edit"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xff02659C),
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
                ElevatedButton(
                  onPressed: () {
                    TtbkBloc detailSuratJalanBloc =
                        BlocProvider.of<TtbkBloc>(context, listen: false);
                    detailSuratJalanBloc.add(
                      TtbkAksi(widget.suratJalanId!, filePath, itemList),
                    );
                  },
                  child: Text("Kirim"),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          title: Text(
            widget.nomorSuratJalan!,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
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
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<BarangBloc, BarangState>(
                builder: (context, state) {
                  if (state is BarangWaiting) {
                    return SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xff029C40),
                        ),
                      ),
                    );
                  }
                  if (state is BarangError) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            spreadRadius: 0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text("Data Error"),
                    );
                  }
                  if (state is BarangLoaded) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            spreadRadius: 0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: DropdownButton(
                        alignment: Alignment.bottomLeft,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2,
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        underline: SizedBox(),
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        hint: Text("Jenis Barang"),
                        value: _valBarang,
                        items: state.modelBarang!.data!
                            .map((e) => DropdownMenuItem(
                                value: e.mASTERBARANGID! +
                                    "-" +
                                    e.mASTERBARANGNAMA!,
                                child: Text(e.mASTERBARANGNAMA.toString())))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _valBarang = value.toString();
                          });
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
              GmsTextField(
                hintText: "Milik Perusahaan",
                controller: _controllerMP,
                typekeyboard: TextInputType.number,
              ),
              GmsTextField(
                hintText: "Milik Relasi",
                controller: _controllerMR,
                typekeyboard: TextInputType.number,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButton(
                  alignment: Alignment.bottomLeft,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  underline: SizedBox(),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  hint: Text("Isi / Kosong"),
                  value: _isiKosong,
                  items: ['isi', 'kosong']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _isiKosong = value.toString();
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => {
                  if (_controllerMP.text.isEmpty || _controllerMR.text.isEmpty)
                    {
                      Fluttertoast.showToast(
                          msg: "Silahkan Isi Form Yang Kosong !")
                    }
                  else
                    {
                      setState(() {
                        itemBarangBaru.add(TtbkModel(_controllerMP.text,
                            _controllerMR.text, _valBarang, _isiKosong));
                        itemList.add([
                          _valBarang!.split('-').first +
                              "," +
                              _controllerMP.text +
                              "," +
                              _controllerMR.text +
                              "," +
                              _isiKosong.toString()
                        ].join());
                      })
                    }
                  // itemBarangBaru?.add(_controllerMR.toString()),
                },
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
                child: const Text("Tambah"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Divider(),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: itemBarangBaru.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(itemBarangBaru[index]
                                      .jenisBarang!
                                      .split('-')
                                      .last
                                      .toString()),
                                  Text("  (${itemBarangBaru[index].isiKosong})")
                                ],
                              ),
                              Container(
                                child: IconButton(
                                  iconSize: 14,
                                  splashRadius: 5,
                                  onPressed: () {
                                    setState(() {
                                      itemBarangBaru.removeAt(index);
                                      itemList.removeAt(index);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Milik Perusahaan : ",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  Text(
                                    itemBarangBaru[index].jmlMP.toString(),
                                    style: TextStyle(color: Colors.black45),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Milik Relasi : ",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  Text(
                                    itemBarangBaru[index].jmlMR.toString(),
                                    style: TextStyle(color: Colors.black45),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Signature(
                  controller: _controller,
                  height: 200,
                  backgroundColor: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _controller.clear,
                    child: Text("Hapus"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff9C0202),
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
                  BlocListener<TtbkBloc, TtbkState>(
                    listener: (context, state) {
                      if (state is TtbkLoaded) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      nama: widget.nama,
                                    )),
                            (route) => false);
                      }
                    },
                    child: BlocBuilder<TtbkBloc, TtbkState>(
                      builder: (context, state) {
                        if (state is TtbkWaiting) {
                          return ElevatedButton(
                            onPressed: null,
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
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
                          );
                        }
                        if (state is TtbkError) {
                          return Text("error");
                        }
                        if (state is TtbkLoaded) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (_controller.isNotEmpty) {
                                final Uint8List? data =
                                    await _controller.toPngBytes();
                                if (data != null) {
                                  final tempDir = await getTemporaryDirectory();
                                  File file = await File(
                                          '${tempDir.path}/image-${widget.suratJalanId}.png')
                                      .create();
                                  file.writeAsBytesSync(data);

                                  alert(file.path);
                                  // TtbkBloc detailSuratJalanBloc =
                                  //     BlocProvider.of<TtbkBloc>(context,
                                  //         listen: false);
                                  // detailSuratJalanBloc.add(
                                  //   TtbkAksi(widget.suratJalanId!, file.path,
                                  //       itemList),
                                  // );

                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Harap Isi Tanda Tangan !");
                              }
                            },
                            child: Text("kirim"),
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
                          );
                        }
                        return ElevatedButton(
                          onPressed: () async {
                            if (_controller.isNotEmpty) {
                              final Uint8List? data =
                                  await _controller.toPngBytes();
                              if (data != null) {
                                final tempDir = await getTemporaryDirectory();
                                File file = await File(
                                        '${tempDir.path}/image-${widget.suratJalanId}.png')
                                    .create();
                                file.writeAsBytesSync(data);

                                alert(file.path);
                                // TtbkBloc detailSuratJalanBloc =
                                //     BlocProvider.of<TtbkBloc>(context,
                                //         listen: false);
                                // detailSuratJalanBloc.add(
                                //   TtbkAksi(widget.suratJalanId!, file.path,
                                //       itemList),
                                // );

                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Harap Isi Tanda Tangan !");
                            }
                          },
                          child: Text("Kirim"),
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
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
