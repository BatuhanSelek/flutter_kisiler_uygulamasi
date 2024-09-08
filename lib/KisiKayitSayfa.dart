import 'package:flutter/material.dart';
import 'package:flutter_kisiler_uygulamasi/main.dart';
import 'package:flutter_kisiler_uygulamasi/models/Kisilerdao.dart';

class Kisikayitsayfa extends StatefulWidget {
  const Kisikayitsayfa({super.key});

  @override
  State<Kisikayitsayfa> createState() => _KisikayitsayfaState();
}

class _KisikayitsayfaState extends State<Kisikayitsayfa> {
  @override
  Widget build(BuildContext context) {
    var tfKisiAdi = TextEditingController();
    var tfKisiTel = TextEditingController();

    Future<void> kayit(String kisi_ad, String kisi_tel) async {
      await Kisilerdao().KisiEkle(kisi_ad, kisi_tel);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Anasayfa()));
    }

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
          "Kişi Kayıt",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAdi,
                decoration: const InputDecoration(
                  hintText: "Kişi Ad",
                ),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: const InputDecoration(
                  hintText: "Kişi Tel",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {
          kayit(tfKisiAdi.text, tfKisiTel.text);
        },
        tooltip: 'Kişi Kayıt',
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: const Text(
          "Kaydet",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
