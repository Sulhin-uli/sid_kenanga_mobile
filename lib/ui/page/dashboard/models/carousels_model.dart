class CarouselModel {
  String image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels =
    carouselsData.map((item) => CarouselModel(item['image'])).toList();

var carouselsData = [
  {"image": "assets/images/kabar-desa.jpeg"},
  {"image": "assets/images/pengaduan.jpeg"},
  {"image": "assets/images/surat.jpeg"},
];
