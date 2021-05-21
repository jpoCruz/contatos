import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {

  TextEditingController _nameController;
  TextEditingController _numberController;
  TextEditingController _emailController;
  TextEditingController _addressController;
  TextEditingController _cepController;

  
  DatabaseReference _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _cepController = TextEditingController();
    
    _ref = FirebaseDatabase.instance.reference().child(('Contacts'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save contacts'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                controller: _nameController,
                decoration:
                InputDecoration(
                  hintText: 'Nome',
                  prefixIcon: Icon(Icons.account_circle, size: 30,),
                  contentPadding: EdgeInsets.all(15),
                ),
                keyboardType: TextInputType.name,
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: _numberController,
                decoration:
                InputDecoration(
                    hintText: 'Número',
                    prefixIcon: Icon(Icons.phone_android, size: 30,),
                    contentPadding: EdgeInsets.all(15),
                ),
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: _emailController,
                decoration:
                InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined, size: 30,),
                  contentPadding: EdgeInsets.all(15),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: _addressController,
                decoration:
                InputDecoration(
                  hintText: 'Endereço',
                  prefixIcon: Icon(Icons.location_city, size: 30,),
                  contentPadding: EdgeInsets.all(15),
                ),
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: _cepController,
                decoration:
                InputDecoration(
                  hintText: 'CEP',
                  prefixIcon: Icon(Icons.place, size: 30,),
                  contentPadding: EdgeInsets.all(15),
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 15),

              ElevatedButton(
                child: Text('Add contact'),
                onPressed: (){
                  saveContact();
                },
              )
            ],
        )
      )
    );
  }

  void saveContact(){
    String name = _nameController.text;
    String number = _numberController.text;
    String email = _emailController.text;
    String address = _addressController.text;
    String cep = _cepController.text;

    Map<String, String> contact = {
      'name':name,
      'number':number,
      'email':email,
      'address':address,
      'cep':cep
    };

    _ref.push().set(contact).then((value){
      Navigator.pop(context);
    });

  }

}
