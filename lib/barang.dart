class Barang{
  String? kode;
  String? nama;
  String? satuan;
  int? hargabeli;
  int? hargajual;

  Barang(this.kode, this.nama, this.satuan, this.hargabeli, this.hargajual);

  barangMap() {
    var mapping = Map<String, dynamic>();
    mapping['kode'] = kode ?? null;
    mapping['nama'] = nama!;
    mapping['satuan'] = satuan!;
    mapping['hargabeli'] = hargabeli!;
    mapping['hargajual'] = hargajual!;
    return mapping;
  }
}
