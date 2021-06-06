class PopularDestinationModel {
  String name;
  String country;
  String image;
  String link;

  PopularDestinationModel(this.name, this.country, this.image, this.link);
}

List<PopularDestinationModel> populars = popularsData
    .map((item) => PopularDestinationModel(
        item['name'], item['country'], item['image'], item['link']))
    .toList();

var popularsData = [
  {
    "name": "WhatsApp",
    "country": "+628",
    "image": "assets/icons/whatsapp.png",
    "link": "asa"
  },
  {
    "name": "Instagram",
    "country": "desakenanga_official",
    "link": "asa",
    "image": "assets/icons/instagram.png"
  },
  {
    "name": "Gmail",
    "country": "pemdeskenanga@gmail.com",
    "link": "asa",
    "image": "assets/icons/gmail.png"
  },
];
