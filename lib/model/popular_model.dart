class PopularDestinationModel {
  String name;
  String country;
  String image;

  PopularDestinationModel(this.name, this.country, this.image);
}

List<PopularDestinationModel> populars = popularsData
    .map((item) =>
        PopularDestinationModel(item['name'], item['country'], item['image']))
    .toList();

var popularsData = [
  {"name": "WhatsApp", "country": "+628", "image": "assets/icons/whatsapp.png"},
  {
    "name": "Instagram",
    "country": "desakenanga_official",
    "image": "assets/icons/instagram.png"
  },
  {
    "name": "Gmail",
    "country": "pemdeskenanga@gmail.com",
    "image": "assets/icons/gmail.png"
  },
];
