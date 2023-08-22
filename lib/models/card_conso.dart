import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class CardCarburant extends StatefulWidget {
  const CardCarburant({super.key,  required this.index, required this.mapChantier, required this.maMap});
  
  final List< Map<String, dynamic>> maMap;
  final int index;
  final Map<String, int> mapChantier;

  @override
  State<CardCarburant> createState() => _CardCarburantState();
}

class _CardCarburantState extends State<CardCarburant> {
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.blue[600],
      elevation: 6,
      child: ListTile(
        title: Text(widget.maMap[widget.index]["nomChantier"], style: const TextStyle( fontSize: 20,)),
        leading: Icon(((int.parse(widget.maMap[widget.index]["qteCarburant"]) <= widget.mapChantier[widget.maMap[widget.index]["nomChantier"]]! ))? Icons.check_circle_sharp : Icons.close, color: ((int.parse(widget.maMap[widget.index]["qteCarburant"]) <= widget.mapChantier[widget.maMap[widget.index]["nomChantier"]]! ))? Colors.greenAccent: Colors.red, size: 30,),
        subtitle: Text( ((int.parse(widget.maMap[widget.index]["qteCarburant"]) <= widget.mapChantier[widget.maMap[widget.index]["nomChantier"]]! ))? "Conso normale: ${widget.maMap[widget.index]["qteCarburant"]}" : "Surconso de: ${int.parse(widget.maMap[widget.index]["qteCarburant"])-widget.mapChantier[]}"),
        /* leading:  Icon( (int.parse(widget.maMap[widget.index]["qteCarburant"]) <= widget.mapChantier[widget.mapChantier[widget.maMap[widget.index]["qteCarburant"]]]!)?  Icons.check_circle_sharp : Icons.close, color:  (int.parse(widget.maMap[widget.index]["qteCarburant"]) <= widget.mapChantier[widget.maMap[widget.index]["qteCarburant"]]!)?  Colors.greenAccent: Colors.red, size: 40,),
        title: Text(widget.maMap[widget.index]["nomChantier"] , style: const TextStyle(fontWeight:  FontWeight.bold, fontSize: 20,),),
      subtitle: Text( (int.parse(widget.maMap[widget.index]["qteCarburant"]) <= widget.mapChantier[widget.mapChantier[widget.maMap[widget.index]["qteCarburant"]]]!)? "Conso normale: ${widget.maMap[widget.index]["qteCarburant"]} L": "Surconso de: ${int.parse(widget.maMap[widget.index]["qteCarburant"]) - widget.mapChantier[widget.mapChantier[widget.maMap[widget.index]["qteCarburant"]]]!} L", style: const TextStyle(color: Colors.white, fontSize: 16),),
      trailing: Text(DateFormat.yMMMd('fr_FR').format(widget.maMap[widget.index]["dateEnregistrement"]), style: const TextStyle(color: Colors.yellow, fontSize: 16)) ,), */)
    );
  }
}