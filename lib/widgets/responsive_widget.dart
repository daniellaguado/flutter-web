import 'package:flutter/material.dart';

abstract class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({Key? key}) : super(key: key);

  Widget buildMobile(BuildContext context);
  Widget buildDesktop(BuildContext context);

/* Utilizo el override porque estoy sobreescribiendo la clase absteacta de arriba
estoy utilizando el context de lo que tengo arriba para utilizarlo aqui abajo */
  @override

  /* Ahora que es lo que pasa aqui en esta parte de la construiccion del buil se coloca una 
  condicion de pantallas, y depende de lo que detecte se mandaria a llamar cierta
  clase y se dibujaria en el otro lado cuando se mande a llamar el NavBar y se dibujará lo que 
  esté dentro de la clase
  
  Lo que dice esa clase es que si el constraints (que no se que es) es mayor a 800 entonces retorna
  un buildMobe, caso contrario un buildDestokp, aqui esta la logica de la parte responsiva
   */
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 800) {
          return buildMobile(context);
        } else {
          return buildDesktop(context);
        }
      },
    );
  }
}
