import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';



class CardCarburant extends StatefulWidget {
   CardCarburant({super.key,  required this.index, required this.mapChantier, required this.maMap,  required this.onPressed1, required this.onPressed2, });
  
  final List< Map<String, dynamic>> maMap;
  final int index;
  
  final Map<String, int> mapChantier;
  final void Function(BuildContext)? onPressed1;
  void Function(BuildContext)? onPressed2;

  @override
  State<CardCarburant> createState() => _CardCarburantState();
}

class _CardCarburantState extends State<CardCarburant> { 
  @override
  Widget build(BuildContext context) {
    Iterable<String> values = widget.maMap.where((map) => map.containsKey("nomChantier")).map((map) => map["nomChantier"]!);
    //Iterable<dynamic> keys = widget.maMap.expand((map) => map.values).toSet().toList();
    return  Slidable(
       
      startActionPane: ActionPane(
        key:  ValueKey(widget.index),
        
        motion:const  ScrollMotion(),
        children:  [
          SlidableAction(
         
            onPressed: (_)=>widget.onPressed1!(context), 
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Suprimer',
          borderRadius: BorderRadius.circular(10),
          
          )
    
        ]),
        endActionPane: ActionPane(
        key:  ValueKey(widget.index),
        
        motion:const  ScrollMotion(),
        children:  [
          SlidableAction(onPressed: (_)=>widget.onPressed2!(context), 
          backgroundColor: const  Color.fromARGB(255, 236, 200, 40),
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Modifier',
          borderRadius: BorderRadius.circular(10),
          
          )
    
        ]),
       
      child: Card(
        color:  Colors.blueGrey[900],
        elevation: 6,
        child: ListTile(
          
          title: Text(widget.maMap[widget.index]["nomChantier"], style: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          //leading: Icon( (int.parse(widget.maMap[widget.index]["qteCarburant"]) <= (widget.mapChantier[(values.toList()[widget.index]).replaceAll(" ", "")])!)? Icons.check_circle_sharp : Icons.close, color: ((int.parse(widget.maMap[widget.index]["qteCarburant"]) <= (widget.mapChantier[(values.toList()[widget.index]).replaceAll(" ", "")])!))? Colors.greenAccent: Colors.red, size: 40,),
          subtitle: Text( (((int.parse(widget.maMap[widget.index]["qteCarburant"])) <= (widget.mapChantier[(values.toList()[widget.index]).replaceAll(" ", "")])!))? "Qté de Carburant: ${widget.maMap[widget.index]["qteCarburant"]!} L" : " Surconso de : ${int.parse(widget.maMap[widget.index]["qteCarburant"]!) - widget.mapChantier[(values.toList()[widget.index]).replaceAll(" ", "")]! } L" , style:  const TextStyle(color: Colors.white, fontWeight: FontWeight.normal ,fontSize: 16, )),
            trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text((widget.maMap[widget.index]["createdAt"]).toString().substring(0,10), style: const TextStyle(color: Colors.yellow, fontSize: 17) ),
              const SizedBox(width: 5,),
              Icon( (int.parse(widget.maMap[widget.index]["qteCarburant"]) <= (widget.mapChantier[(values.toList()[widget.index]).replaceAll(" ", "")])!)? Icons.arrow_upward : Icons.arrow_downward, color: ((int.parse(widget.maMap[widget.index]["qteCarburant"]) <= (widget.mapChantier[(values.toList()[widget.index]).replaceAll(" ", "")])!))? Colors.green: Colors.red, size: 40,),
            ],
          ),  
        )
      ),
    );
  }
}

/* 
Text("${widget.mapChantier[(values.toList()[widget.index]).replaceAll(" ", "")]} L", style: const TextStyle( fontSize: 20, color: Colors.red))
 */