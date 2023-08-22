import '../models/classCarburant.dart';

class ListeCarburant{
  List <Carburant> liste= [
    /* Carburant(nomChantier: "Daloa", quantiteCarburant: 5200.toString(), id: DateTime.now().toString(), dateEnregistrement: DateTime.now()),
    Carburant(nomChantier: "Zénoula", quantiteCarburant: 78000.toString(), id: DateTime.now().toString(), dateEnregistrement: DateTime.now()),
    Carburant(nomChantier: "Issia", quantiteCarburant: 100000.toString(), id: DateTime.now().toString(), dateEnregistrement: DateTime.now()),
    Carburant(nomChantier: "Yamoussoukro", quantiteCarburant: 5000.toString(), id: DateTime.now().toString(), dateEnregistrement: DateTime.now()),
    Carburant(nomChantier: "Bouaké", quantiteCarburant: 1000.toString(), id: DateTime.now().toString(), dateEnregistrement: DateTime.now()),
    Carburant(nomChantier: "M'Pouto", quantiteCarburant: 20000.toString(), id: DateTime.now().toString(), dateEnregistrement: DateTime.now()),  */
  ];

  Map<String, int>mapChantier={
    "Daloa": 5000,
    "Zénoula": 100000,
    "Issia": 15000,
    "Yamoussoukro": 2000,
    "Bouaké": 1000,
    "M'Pouto": 150
  };
}
