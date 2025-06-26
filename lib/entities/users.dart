class User {
  String email;
  String contrasena;
  String nombre;
  String direccion;

  User({
    required this.email,
    required this.contrasena,
    required this.nombre,
    required this.direccion,
  });
}

class Player {
  String name;
  String country;
  int goals;
  int appearances;
  String clubs;
  int age;
  double ratio;
  String posterUrl;

  Player({
    required this.name,
    required this.country,
    required this.goals,
    required this.appearances,
    required this.clubs,
    required this.age,
    required this.ratio,
    required this.posterUrl,
  });

  static List<Player> playerList =[
    Player(
      name: 'Cristiano Ronaldo',
      country: 'Portugal',
      goals: 140,
      appearances: 183,
      clubs: 'Manchester United, Real Madrid, Juventus',
      age: 40,
      ratio: 0.77,
      posterUrl: 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg'

    ),
    Player(
      name: 'Lionel Messi',
      country: 'Argentina',
      goals: 129,
      appearances: 163,
      clubs: 'Barcelona, Paris Saint-Germain',
      age: 38,
      ratio: 0.79,
      posterUrl: 'https://upload.wikimedia.org/wikipedia/commons/b/b4/Lionel-Messi-Argentina-2022-FIFA-World-Cup_%28cropped%29.jpg'

    ),
    Player(
      name: 'Robert Lewandowski',
      country: 'Poland',
      goals: 105,
      appearances: 133,
      clubs: 'Borussia Dortmund, Bayern Munich, Barcelona',
      age: 36,
      ratio: 0.79,
      posterUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/2019147200143_2019-05-27_Fussball_1.FC_Kaiserslautern_vs_FC_Bayern_M%C3%BCnchen_-_Sven_-_1D_X_MK_II_-_2462_-_B70I0762_%28cropped%29_%28cropped%29.jpg/250px-2019147200143_2019-05-27_Fussball_1.FC_Kaiserslautern_vs_FC_Bayern_M%C3%BCnchen_-_Sven_-_1D_X_MK_II_-_2462_-_B70I0762_%28cropped%29_%28cropped%29.jpg'

    ),
    Player(
      name: 'Karim Benzema',
      country: 'France',
      goals: 90,
      appearances: 152,
      clubs: 'Lyon, Real Madrid',
      age: 37,
      ratio: 0.59,
      posterUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2_0x9QJB6r1C7VVbiHj4pTwCOnEJ2GwXsgw&s'

    ),
    Player(
      name: 'Raúl',
      country: 'Spain',
      goals: 71,
      appearances: 142,
      clubs: 'Real Madrid, Schalke 04',
      age: 47,
      ratio: 0.50,
      posterUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnirgvb6IsZvH5pvV7ktbCRt_I7evCoHsEew&s'

    ),
    Player(
      name: 'Thomas Muller',
      country: 'Germany',
      goals: 57,
      appearances: 163,
      clubs: 'Bayern Munich',
      age: 35,
      ratio: 0.35,
      posterUrl: 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Thomas_M%C3%BCller_2022_%28cropped%29.jpg'

    ),
    Player(
      name: 'Ruud Van Nistelrooy',
      country: 'Netherlands',
      goals: 56,
      appearances: 73,
      clubs: 'PSV Eindhoven, Manchester United, Real Madrid',
      age: 48,
      ratio: 0.77,
      posterUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Van_Nistelrooy_%282007%29.JPG/250px-Van_Nistelrooy_%282007%29.JPG'

    ),
    Player(
      name: 'Kylian Mbappé',
      country: 'France',
      goals: 55,
      appearances: 87,
      clubs: 'Monaco, Paris Saint-Germain, Real Madrid',
      age: 26,
      ratio: 0.64,
      posterUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/57/2019-07-17_SG_Dynamo_Dresden_vs._Paris_Saint-Germain_by_Sandro_Halank%E2%80%93129_%28cropped%29.jpg'

    ),
    Player(
      name: 'Thierry Henry',
      country: 'France',
      goals: 50,
      appearances: 112,
      clubs: 'Monaco, Arsenal, Barcelona',
      age: 47,
      ratio: 0.45,
      posterUrl: 'https://tmssl.akamaized.net/images/foto/galerie/thierry-henry-1417524348-3352.jpg'
    ),
    Player(
      name: 'Erling Haaland',
      country: 'Norway',
      goals: 49,
      appearances: 48,
      clubs: 'Red Bull Salzburgo, B. V. Borussia Dortmund, Manchester City F.C.',
      age: 24,
      ratio: 1.02,
      posterUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Erling_Haaland_2023_%28cropped-v2%29.jpg/250px-Erling_Haaland_2023_%28cropped-v2%29.jpg'
    ),
    Player(
      name: 'Alfredo Di Stefano',
      country: 'Argentina, Spain',
      goals: 49,
      appearances: 58,
      clubs: 'Real Madrid',
      age: 88,
      ratio: 0.84,
      posterUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a7/Di_Stefano_argentina_%28colores%29.png' 
    ),
  ];
}