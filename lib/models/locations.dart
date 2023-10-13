class Province {
  final String name;
  final List<CityTown> cities;

  Province({required this.name, required this.cities});
}

class CityTown {
  final String name;
  final List<Neighbourhood> neighbourhoods;

  CityTown({required this.name, required this.neighbourhoods});
}

class Neighbourhood {
  final String name;
  final Coordinates coordinates;

  Neighbourhood({required this.name, required this.coordinates});
}

class Coordinates {
  final String latitude;
  final String longitude;

  Coordinates({required this.latitude, required this.longitude});
}

List<Province> locations = <Province>[
  Province(
    name: 'bulawayo cental',
    cities: <CityTown>[
      CityTown(name: 'bulawayo', neighbourhoods: <Neighbourhood>[
        (Neighbourhood(
            name: 'nketa',
            coordinates:
                Coordinates(latitude: '-20.2009487', longitude: '28.5301850'))),
        (Neighbourhood(
            name: 'nkulumane',
            coordinates:
                Coordinates(latitude: '-20.1811821', longitude: '28.5301850'))),
        (Neighbourhood(
            name: 'newton',
            coordinates:
                Coordinates(latitude: '-20.2219338', longitude: '28.5725030'))),
      ]),
    ],
  ),
  Province(
    name: 'harare central',
    cities: <CityTown>[
      CityTown(name: 'harare', neighbourhoods: <Neighbourhood>[
        (Neighbourhood(
            name: 'Eastlea',
            coordinates:
                Coordinates(latitude: '-17.8175606', longitude: '31.0693400'))),
        (Neighbourhood(
            name: 'tynwald south',
            coordinates:
                Coordinates(latitude: '-17.8063929', longitude: '30.9446058'))),
        (Neighbourhood(
            name: 'borrowdale brook',
            coordinates:
                Coordinates(latitude: '-17.7163942', longitude: '31.1424001')))
      ])
    ],
  ),
  Province(
    name: 'manicaland',
    cities: <CityTown>[
      CityTown(name: 'mutare', neighbourhoods: <Neighbourhood>[
        (Neighbourhood(
            name: 'chikanga',
            coordinates:
                Coordinates(latitude: '-18.9706980', longitude: '32.6362231'))),
      ]),
      CityTown(name: 'chipinge', neighbourhoods: <Neighbourhood>[
        (Neighbourhood(
            name: 'ward 1',
            coordinates:
                Coordinates(latitude: '-20.1857337', longitude: '32.6291585'))),
      ]),
      CityTown(name: 'chimanimani', neighbourhoods: <Neighbourhood>[
        (Neighbourhood(
            name: 'ward 1',
            coordinates:
                Coordinates(latitude: '-20.1857337', longitude: '32.6291585'))),
      ]),
      CityTown(name: 'rusape', neighbourhoods: <Neighbourhood>[
        (Neighbourhood(
            name: 'vhengere',
            coordinates:
                Coordinates(latitude: '-18.5473954', longitude: '32.119246'))),
      ])
    ],
  )
];

var populatedCities = [
  "Harare",
  "Bulawayo",
  "Chitungwiza",
  "Mutare",
  "Gweru",
  "Epworth",
  "Kwekwe",
  "Kadoma",
  "Masvingo",
  "Chinhoyi",
  "Marondera",
  "Norton",
  "Chegutu",
  "Bindura",
  "Zvishavane",
  "Victoria Falls",
  "Hwange",
  "Redcliff",
  "Rusape",
  "Chiredzi",
  "Beitbridge",
  "Kariba",
  "Karoi",
  "Gokwe",
  "Chipinge",
  "Shurugwi",
  "Gwanda",
  "Mashava",
  "Murewa",
  "Raffingora",
  "Plumtree",
  "Nkayi",
  "Banket",
  "Inyati",
  "Mvurwi",
  "Penhalonga",
  "Shamva",
  "Mvuma",
  "Insiza",
  "Murambinda",
  "Nyika",
];
