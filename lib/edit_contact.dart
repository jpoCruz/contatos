import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class EditContact extends StatefulWidget {

  String contactKey;
  EditContact({this.contactKey});


  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

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

    getContactDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar contato'),
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
                  child: Text('Salvar'),
                  onPressed: (){
                    saveContact();
                  },
                )
              ],
            )
        )
    );
  }

  void getContactDetail() async{
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();

    Map contact = snapshot.value;

    _nameController.text = contact['name'];
    _numberController.text = contact['number'];
    _emailController.text = contact['email'];
    _addressController.text = contact['address'];
    _cepController.text = contact['cep'];
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

    _ref.child(widget.contactKey).update(contact).then((value){
      Navigator.pop(context);
    });

  }

}
