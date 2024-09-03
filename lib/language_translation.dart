import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {

  var language=['Hindi','English','German'];
  var originLanguages='from';
  var destinationLanguages='to';
  var output='';
  TextEditingController languageController = TextEditingController();

  void translate(String src,String dest,String input) async{
    GoogleTranslator translator = new GoogleTranslator();
    var translation= await translator.translate(input,from: src,to: dest);
    setState(() {
      output=translation.text.toString();
    });
    if(src=='--'||dest=='--'){
      setState(() {
        output='failed to translate';
      });
    }
  }

  String getLanguageCode(String language){
    if(language=='English'){
      return 'en';
    }else if(language=='Hindi'){
      return 'hi';
    }else if(language=='German'){
      return 'de';
    }
    return '--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(title: Text('Language Translator'),centerTitle: true,
      backgroundColor: Colors.black54,
      elevation: 0,),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(focusColor: Colors.white,
                    iconDisabledColor:Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    originLanguages,style: TextStyle(color: Colors.white),
                  ),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: language.map((String dropDownStringItem){
                    return DropdownMenuItem(child: Text(dropDownStringItem),
                      value: dropDownStringItem,);
                  }).toList(),
                    onChanged: (String? value){
                    setState(() {
                      originLanguages=value!;
                    });
                    },
                  ),
                  SizedBox(height: 40,),
                  Icon(Icons.arrow_right_alt_outlined,color: Colors.white,size: 40,),
                  SizedBox(width: 40,),
                  DropdownButton(focusColor: Colors.white,
                    iconDisabledColor:Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguages,style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: language.map((String dropDownStringItem){
                      return DropdownMenuItem(child: Text(dropDownStringItem),
                        value: dropDownStringItem,);
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        destinationLanguages=value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Padding(padding: EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter your Text',
                  labelStyle: TextStyle(fontSize: 15,color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1),
                  ),
                  errorStyle:TextStyle(color: Colors.pink,fontSize: 15),
                ),
                controller: languageController,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'enter text to translate';
                  }
                  return null;
                },
              ),),
              Padding(padding: EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shadowColor: Color(0xff2b3c5a)),
                  onPressed: (){
                    translate(getLanguageCode(originLanguages), getLanguageCode(destinationLanguages), languageController.text.toString());
                  },
                  child: Text('Translate')),
              ),
              SizedBox(height: 20,),
              Text(
                "\n$output",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
