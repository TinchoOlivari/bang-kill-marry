import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:full_picado/paginas/principal.dart';

class PaginaAgregarAmigos extends StatefulWidget {
  final List<String> nombres_participantes;
  const PaginaAgregarAmigos({Key key, this.nombres_participantes})
      : super(key: key);

  @override
  _PaginaAgregarAmigosState createState() => _PaginaAgregarAmigosState();
}

class _PaginaAgregarAmigosState extends State<PaginaAgregarAmigos> {
  final List<String> nombres_amigos = <String>[];

  @override
  void initState() {
    nombres_amigos.addAll(widget.nombres_participantes);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();

  void agregarItems(BuildContext context) {
    if (nameController.text.length > 2 && nameController.text.length <= 20) {
      if (nombres_amigos.contains(nameController.text.toLowerCase())) {
        showSnackError(
            context,
            nameController.text.toLowerCase().capitalize +
                ' ya esta en la lista');
      } else {
        setState(() {
          nombres_amigos.insert(0, nameController.text.toLowerCase());
        });
        nameController.clear();
      }
    } else {
      showSnackError(context, 'El nombre debe tener entre 2 y 20 letras');
    }
  }

  void borrarItems(BuildContext context, int index) {
    setState(() {
      nombres_amigos.removeAt(index);
    });
  }

  void showSnackError(context, String text) {
    if (this.mounted) {
      _scaffoldstate.currentState.hideCurrentSnackBar();
      final snackBar =
          SnackBar(behavior: SnackBarBehavior.floating, content: Text(text));
      _scaffoldstate.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text('Agrega a cualquier amigo'),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: new TextField(
                          controller: nameController,
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15.0),
                                ),
                              ),
                              hintStyle: new TextStyle(color: Colors.grey[500]),
                              hintText: "Nombre/Apodo",
                              fillColor: Colors.white70),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 0),
                        child: RawMaterialButton(
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.add,
                          ),
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          splashColor: Colors.teal,
                          onPressed: () {
                            agregarItems(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                nombres_amigos.length == 0
                    ? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Empezá sumando amigos\na la lista!',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.add, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 68),
                          itemCount: nombres_amigos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: new BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.grey[100]
                                      : Colors.transparent),
                              child: ListTile(
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      borrarItems(context, index);
                                    },
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                      '${nombres_amigos[index].capitalize}')),
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
          nombres_amigos.length < 4
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: Colors.teal,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(FourthPageRoute(
                            nombres_amigos, widget.nombres_participantes));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Jugar!',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

extension on String {
  String get capitalize => this
      .split(" ")
      .map((str) => str[0].toUpperCase() + str.substring(1))
      .join(" ");
}

class FourthPageRoute extends CupertinoPageRoute {
  FourthPageRoute(nombres_amigos, nombres_participantes)
      : super(
          builder: (BuildContext context) => new PaginaPrincipal(
            nombres_amigos: nombres_amigos,
            nombres_participantes: nombres_participantes,
          ),
        );
}
