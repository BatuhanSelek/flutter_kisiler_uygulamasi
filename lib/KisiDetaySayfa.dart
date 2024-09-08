// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_kisiler_uygulamasi/main.dart';

import 'package:flutter_kisiler_uygulamasi/models/Kisiler.dart';
import 'package:flutter_kisiler_uygulamasi/models/Kisilerdao.dart';

class Kisidetaysayfa extends StatefulWidget {
  Kisiler kisi;
  Kisidetaysayfa({
    super.key,
    required this.kisi,
  });

  @override
  State<Kisidetaysayfa> createState() => _KisidetaysayfaState();
}

class _KisidetaysayfaState extends State<Kisidetaysayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  Future<void> guncelle(int kisi_id, String kisi_ad, String kisi_tel) async {
    await Kisilerdao().KisiGuncelle(kisi_id, kisi_ad, kisi_tel);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Anasayfa()));
  }

  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.amber,
        title: const Text(
          "Kişi Detay",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(
                  labelText: "Kişi Ad",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.amber,
                      width: 6.0,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: InputDecoration(
                  labelText: "Kişi Tel",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.amber,
                      width: 6.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {
          guncelle(widget.kisi.kisi_id, tfKisiAdi.text, tfKisiTel.text);
        },
        tooltip: 'Kişi Güncelle',
        icon: const Icon(
          Icons.update,
          color: Colors.white,
        ),
        label: const Text("Güncelle",
            style: TextStyle(color: Colors.white, fontSize: 17)),
      ),
    );
  }
}
