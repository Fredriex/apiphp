import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'barang.dart';
class ViewBarang extends StatefulWidget{
  final Barang barang;
  const ViewBarang({Key? key, required this.barang}) : super(key: key);
  @override
  State<ViewBarang> createState() => _ViewBarangState();
}
class _ViewBarangState extends State<ViewBarang> {
  @override
  Widget build(BuildContext context) {
    print("Harga Beli: ${widget.barang.hargabeli}");
    print("Harga Jual: ${widget.barang.hargajual}");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('View Barang'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Detail Barang",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Kode',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(widget.barang.kode ?? '',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Nama',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(widget.barang.nama ?? '',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Satuan',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(widget.barang.satuan ?? '',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Harga Beli',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(widget.barang.hargabeli.toString(),
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Harga Jual',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(widget.barang.hargajual.toString(),
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ]
            )
        )
    );
  }
}
