import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:newsapi/todoapi.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isLoading= true;
  void initState (){
    super.initState();
    _getData();
  }
  TodoModelApi? dataFromApi;
  _getData()async{
    try{
      String url="https://dummyjson.com/todos";
      http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode==200){
        dataFromApi=TodoModelApi.fromJson(json.decode(res.body));
        _isLoading=false;
        setState(() {
          
        });
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-DO",style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),backgroundColor: const Color.fromARGB(255, 255, 255, 255)),),backgroundColor: Colors.red,centerTitle: true,),
      body:_isLoading? Padding(padding: EdgeInsets.all(5),
      child: Center(child: CircularProgressIndicator(),),
      ) 
    : dataFromApi==null?
    Center(child: Text("failed to load data"),)
      
      :Container(
        color: const Color.fromARGB(255, 253, 233, 46),
        child: Expanded(
          child: ListView.separated(itemBuilder: (context,index){
           
            return Container(
          height: 5,width: 5,
            color: Colors.black,
             
            );
          }, separatorBuilder: (context,index){
          
             final todo=dataFromApi!.todos[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("ID: ${todo.id}"),
                  Text("UserID:${todo.userId}"),
                  Text("TO-DO:${todo.todo}",textAlign: TextAlign.justify,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 25),),
                  Text("Completed:${todo.completed}")
                ],
              ),
            );
          }, itemCount: dataFromApi!.todos.length),
        ),
      ),
    );
  }
}