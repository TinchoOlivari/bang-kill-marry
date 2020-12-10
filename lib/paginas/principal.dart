import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "dart:math";

class PaginaPrincipal extends StatefulWidget {
  final List<String> nombres;
  const PaginaPrincipal({Key key, this.nombres}) : super(key: key);

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  // Los 3 elegidos por turno
  final List<String> elegidos = <String>[];
  final List<String> lista_nombres = <String>[];

  int orden = 0;

  @override
  void initState() {
    super.initState();
    lista_nombres.addAll(widget.nombres);
    lista_nombres.removeWhere((nombre) => nombre == widget.nombres[orden]);
    randomizar(lista_nombres);
    randomizar(lista_nombres);
    randomizar(lista_nombres);
    elegir();
  }

  void randomizar(List<String> lista) {
    lista.shuffle();
    elegidos.clear();
  }

  void elegir() {
    lista_nombres.removeWhere((nombre) => nombre == widget.nombres[orden]);
    elegidos.insert(0, lista_nombres[0]);
    elegidos.insert(1, lista_nombres[1]);
    elegidos.insert(2, lista_nombres[2]);
  }

  void sumar_uno() {
    if (orden >= lista_nombres.length - 1) {
      setState(() {
        orden = 0;
      });
    } else {
      setState(() {
        orden += 1;
      });
    }
  }

  void restaurar() {
    lista_nombres.clear();
    lista_nombres.addAll(widget.nombres);
  }

  @override
  Widget build(BuildContext context) {
    print(lista_nombres);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Turno de:',
                    style: TextStyle(fontSize: 32, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    '${widget.nombres[orden]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    height: 30,
                    thickness: 1,
                  ),
                  padding: EdgeInsets.only(left: 32, right: 32),
                  itemCount: elegidos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: Text(
                      elegidos[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: MaterialButton(
                color: Colors.teal,
                textColor: Colors.white,
                onPressed: () {
                  restaurar();
                  sumar_uno();
                  randomizar(lista_nombres);
                  elegir();
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
                        'Siguiente',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}