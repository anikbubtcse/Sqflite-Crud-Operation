import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_crud_operation/models/person_model.dart';
import '../bloc/person_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  void initState() {
    context.read<PersonBloc>().add(GetPersonEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sqflite Crud Operation",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue.shade500,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<PersonBloc, PersonState>(
                  listener: (context, personState) {
                if (personState is PersonAddLoaded) {
                  var snackBar = const SnackBar(
                      content: Text("Person successfully added"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (personState is PersonDeleteLoaded) {
                  var snackBar = const SnackBar(
                      content: Text("Person successfully Deleted"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (personState is PersonUpdateLoaded) {
                  var snackBar = const SnackBar(
                      content: Text("Person successfully Updated"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (personState is PersonError) {
                  var snackBar = SnackBar(content: Text(personState.message));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }, builder: (context, personState) {
                if (personState is PersonInitial ||
                    personState is PersonLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue.shade500,
                    ),
                  );
                }

                if (personState is PersonGetLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: personState.person.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(personState.person[index].name),
                          subtitle: Text(personState.person[index].email),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              context.read<PersonBloc>().add(DeletePersonEvent(
                                  PersonModel(
                                      name: personState.person[index].name,
                                      id: personState.person[index].id,
                                      email: personState.person[index].email)));
                            },
                          ),
                        ),
                      );
                    },
                  );
                }

                if (personState is PersonAddLoaded) {
                  context.read<PersonBloc>().add(GetPersonEvent());
                }

                if (personState is PersonDeleteLoaded) {
                  context.read<PersonBloc>().add(GetPersonEvent());
                }

                return Container();
              }),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Provide Person information',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            content: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: idController,
                                  onChanged: (value) {
                                    idController.text = value.toString();
                                    setState(() {});
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Provide person unique id",
                                      hintStyle: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ),
                                TextFormField(
                                  controller: nameController,
                                  onChanged: (value) {
                                    nameController.text = value.toString();
                                    setState(() {});
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Provide person name",
                                      hintStyle: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  onChanged: (value) {
                                    emailController.text = value.toString();
                                    setState(() {});
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Provide person email",
                                      hintStyle: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Send'),
                                onPressed: () {
                                  context.read<PersonBloc>().add(AddPersonEvent(
                                      PersonModel(
                                          name: nameController.text,
                                          id: int.parse(idController.text),
                                          email: emailController.text)));

                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.blue.shade500,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
