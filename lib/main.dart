import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kisiler_uygulamasi/KisiDetaySayfa.dart';
import 'package:flutter_kisiler_uygulamasi/KisiKayitSayfa.dart';
import 'package:flutter_kisiler_uygulamasi/models/Kisiler.dart';
import 'package:flutter_kisiler_uygulamasi/models/Kisilerdao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kişiler Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = '';

  Future<List<Kisiler>> tumKisileriGoster() async {
    var kisilerListesi = await Kisilerdao().tumKisiler();
    return kisilerListesi;
  }

  Future<List<Kisiler>> aramaYap(String aramaKelimesi) async {
    var kisilerListesi = await Kisilerdao().KisiArama(aramaKelimesi);
    return kisilerListesi;
  }

  Future<void> sil(int kisi_id) async {
    await Kisilerdao().KisiSil(kisi_id);
    setState(() {});
  }

  Future<bool> uygulamayiKapat() async {
    await exit(0);
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
            uygulamayiKapat();
          },
        ),
        backgroundColor: Colors.amber,
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(
                  hintText: "Arama Yap",
                ),
                onChanged: (aramaSonucu) {
                  print("Arama Sonucu : $aramaSonucu");
                  setState(() {
                    aramaKelimesi = aramaSonucu;
                  });
                },
              )
            : const Text(
                "Kişiler",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      aramaKelimesi = "";
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                ),
        ],
      ),
      body: FutureBuilder(
        future:
            aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKisileriGoster(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kisilerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kisilerListesi!.length,
              itemBuilder: (context, index) {
                var kisi = kisilerListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Kisidetaysayfa(
                                  kisi: kisi,
                                )));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            kisi.kisi_ad,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            kisi.kisi_tel,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              sil(kisi.kisi_id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Kisikayitsayfa()));
        },
        tooltip: 'Kişi Ekle',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
