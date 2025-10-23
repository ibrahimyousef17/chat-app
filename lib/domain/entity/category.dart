class Category{
  String id ;
  String title ;
  String image ;
  Category({required this.id,required this.title,required this.image});

  static List<Category> getCategory(){
    return [
      Category(id: 'sports', title: 'Sports', image: 'assets/images/sports_icon.png'),
      Category(id: 'movies', title: 'Movies', image: 'assets/images/film_icon.png'),
      Category(id: 'music', title: 'Music', image: 'assets/images/music_icon.png'),
    ];
  }
}