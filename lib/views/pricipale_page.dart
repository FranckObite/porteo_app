// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



import '../controllers/database_helper.dart';
import '../controllers/listCarburant.dart';
import '../models/card_conso.dart';

import '../models/monTextField.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage>  {

  late TextEditingController nomChantier;
  late TextEditingController quantiteCarburant;
  
  

  String? valeurSelectionner;

  List<String> nomDesmChantier =[
    'Daloa ',
    'Zénoula ',
    'Issia ',
    "Yamoussoukro",
    "Bouaké",
    "M'Pouto"
  ];


  // Toutes les notes
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // Récuperation de toutes les donnée de la bd
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

 
  

  @override
  void initState() {
    // TODO: implement initState
    nomChantier= TextEditingController();
    quantiteCarburant= TextEditingController();
    
    _refreshJournals(); // Chargement au démarrage de l'application
    
   
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nomChantier.dispose();
    quantiteCarburant.dispose();
    
    
    super.dispose();
  }

  //List <Carburant> liste= ListeCarburant().liste;
  Map <String, int> mapChantier=ListeCarburant().mapChantier;


   
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Image.asset("images/log.png", width: 100, height: 100,),
        actions: [IconButton(onPressed: ()=> monBottomSheet(null), icon: const Icon(Icons.add),color: Colors.yellow[600], iconSize: 30,)],
      ), 
      body:  _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )  
            :Container(
        width:  MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue[600],
        child:  Column(
          children: [
            Stack(
              children: [Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/Porteo1.jpg"), fit: BoxFit.cover),
                 
                  borderRadius:  BorderRadius.all( Radius.circular(50))
                  ),
                ),
                 Padding(
                  padding:  const EdgeInsets.all(30.0),
                  child:  Text("Surveillez votre Consomations", style: GoogleFonts.roboto(fontSize: 35, fontWeight: FontWeight.bold),),
                )
                 ]
            ),
          const  SizedBox(height: 10,),
           Expanded ( 
            // ignore: unrelated_type_equality_checks
            child: (_journals.isEmpty)?  Image.asset('images/naData.png'):  SizedBox(
                    
                  child: ListView.separated(itemBuilder: (context, index){
          
            return CardCarburant(
              
             index: index, mapChantier: mapChantier, maMap: _journals);
                  }, 
                  separatorBuilder: (context, index){
            return  const Divider(color: Colors.white);
                  }, itemCount: _journals.length  ,
                ),
          ),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[600],
        onPressed: ()=> monBottomSheet( null), child: const Icon(Icons.add,),),
    );
  }


  // Insérer une nouvelle note dans la base de données
  Future<void> _addItem({required String nomChantier, required String quantiteCarburant, }) async {
    await SQLHelper.createItem(
        nomChantier, quantiteCarburant, );
    _refreshJournals();
  }

  // Mettre une note à jour
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, nomChantier.text, quantiteCarburant.text,);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Votre note a bien été modifiée!'),
    ));
    _refreshJournals();
  }

   // Supprimer une note
  void _deleteItem(int id, String nomChantier, String quantiteCarburant, ) async {
    await SQLHelper.deleteItem(id);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Votre note intitulée: $nomChantier a bien été supprimée!'),
    ));
    _refreshJournals();
  }

  void _showShwoDialog(int index, String nomChantier) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Supression de données"),
              content: Text("souhaittez vous suprimer cette note: $nomChantier ?"),
              actions: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Non")),
                    TextButton(
                        onPressed: () {
                          _deleteItem(_journals[index]['id'],
                              _journals[index]['nomChantier'],
                              _journals[index]['quantiteCarburant'],
                              
                              );
                          Navigator.of(context).pop();
                        },
                        child: const Text("Oui")),
                  ],
                )
              ],
            ));
  }





    void monBottomSheet( int? id) async{
      if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      nomChantier.text = existingJournal['nomChantier'];
      quantiteCarburant.text = existingJournal['qteCarburant'];
      
    }
     showModalBottomSheet (
          showDragHandle: true,
          backgroundColor: Colors.white,
          barrierColor: Colors.deepPurpleAccent,
          isScrollControlled: true,
          isDismissible: false,
          context: context, builder: (_)=>        
            Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // Rendre le clavier souple pour pouvoir écrire
                bottom: MediaQuery.of(context).viewInsets.bottom + 100,
              ),
              height: 550,
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.only(topRight: Radius.circular(20),
                topLeft:  Radius.circular(20)),
              ),
              child:    Padding(padding:   const EdgeInsets.only(left: 20, right: 20, top: 20.0,),
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MonTexfield(controller: nomChantier, label: "Cliquez pour sélectionner un Chantier ", icon: Icons.precision_manufacturing_sharp, readOnly: true, 
                  onTap:  () async {

                    String newValue = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                      return AlertDialog(
                      title: const Text('Selection du Chantier'),
                      content: 
                      DropdownButton<String>(
                      value: valeurSelectionner,
                      items: nomDesmChantier.map((String value) {
                      return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                    }).toList(),
                     onChanged: (newValue) {
                      Navigator.of(context).pop(newValue);
                    }, 
                  ),
                );
              },
            );

          setState(() {
          nomChantier.text = newValue;
          });
                  },),
                    MonTexfield(controller: quantiteCarburant, label: "Carburant Consomé", icon: Icons.local_gas_station_outlined, readOnly: false,),
                  
                    
                    const SizedBox(height:  60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      monButton(text: "Annuler", onPressed: ()async{
                        Navigator.of(context).pop();
                        setState(() {
                          nomChantier.text="";
                          quantiteCarburant.text="";
                          
                        });
                        
                      }, color: Colors.red),

                      const SizedBox(width: 30),

                      monButton(text: (id == null )? 'Ajouter' : 'Modifier', 
                      onPressed: () async {
                      
                         if (id == null) {
                        await _addItem(nomChantier: nomChantier.text, quantiteCarburant: quantiteCarburant.text,);
                      } if  (id != null) {
                        await _updateItem(id);
                      }
                      
                      setState(() {
                          nomChantier.text="";
                          quantiteCarburant.text="";
                        });
 
                         
                       Navigator.of(context).pop();
                    },
                   

                       color: Colors.green),
                      

                    ],)
                       
                  ],
                ),
              ),),  
            ),
          
        );
  }

  
  ElevatedButton monButton({required String text, required  Future <void> Function()? onPressed, required Color color,}) {
    return ElevatedButton(   
         style: ElevatedButton.styleFrom(backgroundColor: color),     
         onPressed: onPressed, 
         child:  Text(text, style:  const TextStyle(color:  Colors.white),)
    );
  }
}