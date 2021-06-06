import 'package:sid_kenanga_mobile/ui/page/dashboard/models/visi_misi_model.dart';

VisiMisi visiMisi = null;

class TravlogModel {
  String name;
  String content;
  String place;
  String image;

  TravlogModel(this.name, this.content, this.place, this.image);
}

List<TravlogModel> travlogs = travlogsData
    .map((item) => TravlogModel(
        item['name'], item['content'], item['place'], item['image']))
    .toList();

var travlogsData = [
  {
    "name": "",
    "content":
        "Jl. Pesarean No.0255 45213, Kenanga, Sindang, Kabupaten Indramayu, Jawa Barat 45226",
    "place": "",
    "image": "assets/images/alamat.jpg"
  },
  {
    "name": "",
    "content": "memuat",
    "place": "",
    "image": "assets/images/visi.jpeg"
  },
  {
    "name": "",
    "content": "memuat",
    "place": "",
    "image": "assets/images/misi.jpeg"
  },
];
