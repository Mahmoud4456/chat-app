import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {
  const FormItem({this.opscure= false ,this.onChange ,super.key, this.label});
  final Function(String)? onChange ;
 final String? label ;
 final bool opscure ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return "field is required";
        }
        return null;
      },
      obscureText: opscure,
      onChanged: onChange,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        labelText: label,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide:BorderSide(
              color: Colors.white
          ),
        ) ,
      ),
    );
  }
}


