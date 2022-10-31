import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:website/src/my_web_page.dart';
import 'package:website/src/navigation_bar/navbar_button.dart';
import 'package:website/widgets/responsive_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NavBar extends ResponsiveWidget {
  const NavBar({Key? key}) : super(key: key);
  /* Esto es lo que significa crear una clase abstracta
  que yo puedo extenderla y me va a generar los valores que yo voy a tener 
  ya creados al momento de crear mi clase abstracta  */

  @override
  Widget buildDesktop(BuildContext context) {
    return DesktopNavbar();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return MobileNavbar();
  }
}

class DesktopNavbar extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isScrolled = ref.watch(scrolledProvider.state).state;
    /* Aqui lo que se hace es recibir(mirar [propiedad watch]) el valor del provider por referencia, y 
    mirar si su estado cambia y eso se hace con la propiedad watch que se le aplica al widget al cual se 
    hace referencia, que es el ScrolledProvider, en su estado. 
    Eso es almacenado en la variable final isScrolled que logicamente recibe un bool */

    final Color navBarColor = isScrolled ? Colors.blue : Colors.white;
    /* Ahora  lo que se hace es almacenar una condicion en la variable navBarColor, que es la 
    siguiente: 
    si isScrolled es true (que su valor por defecto es false), entonces '?' se escoge Colors.blue
    sino ':' se escoge Colors.white, y cualquiera que sea resolucion de la condicional se va almacenar
    en la variable navBarColor, que es una variable tipo Color, asi que facilmente podemos aplicarla
    en cualquier cosa que necesite color
    */

    return Container(
      color: navBarColor,
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              const FadeInImage(
                placeholder: NetworkImage(
                    'https://media1.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif'),
                width: 50,

                // height: 40.0,
                image: AssetImage("assets/logo.png"),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Company Name",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
              ),
              Expanded(child: Container()),
              NavBarButton(
                ontap: () =>
                    ref.read(currentPageProvider.state).state = homeKey,
                text: "Home",
              ),
              NavBarButton(
                ontap: () =>
                    ref.read(currentPageProvider.state).state = featureKey,
                text: "Features",
              ),
              NavBarButton(
                ontap: () =>
                    ref.read(currentPageProvider.state).state = screenshotKey,
                text: "Screenshot",
              ),
              NavBarButton(
                ontap: () =>
                    ref.read(currentPageProvider.state).state = contactKey,
                text: "Contact",
              ),
            ],
          )),
    );
  }
}

class MobileNavbar extends HookConsumerWidget {
  const MobileNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isScrolled = ref.watch(scrolledProvider.state).state;
    /* Aqui lo que se hace es recibir(mirar [propiedad watch]) el valor del provider por referencia, y 
    mirar si su estado cambia y eso se hace con la propiedad watch que se le aplica al widget al cual se 
    hace referencia, que es el ScrolledProvider, en su estado. 
    Eso es almacenado en la variable final isScrolled que logicamente recibe un bool */

    final Color navBarColor = isScrolled ? Colors.blue : Colors.white;
    /* Ahora  lo que se hace es almacenar una condicion en la variable navBarColor, que es la 
    siguiente: 
    si isScrolled es true (que su valor por defecto es false), entonces '?' se escoge Colors.blue
    sino ':' se escoge Colors.white, y cualquiera que sea resolucion de la condicional se va almacenar
    en la variable navBarColor, que es una variable tipo Color, asi que facilmente podemos aplicarla
    en cualquier cosa que necesite color
    */

    final containerHeight = useState<double>(0.0);
    //Variable usada para definir el alto del container
    final height = containerHeight.value > 0 ? 0.0 : 240.0;
    /* Esta es la logica utilizada para poder expandir el menu y es almacenada en el onTap del
    icono del menu, que al final no es mas que decir que si el containerHeight es mayor a 0 [no?] entonces
    es 0, [si es mayor a 0?] entonces colocale un height de 240, y vuelve aplicar la logica, suponiendo que 
    ya el height sea 240, se vuelve a preguntar (ya que esta en el ontap) el containerHegiht (que ya estaria
    en 240) es mayor a 0? [en este caso es si, entonces es 0.0]*/

    return Stack(
      children: [
        AnimatedContainer(
          margin: const EdgeInsets.only(top: 85),
          /* Este margin fue la solución para que el menú se pudiera mostrar entero, ya que solo se mostraba
          cortado */
          curve: Curves.ease,
          duration: const Duration(microseconds: 350),
          height: containerHeight.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // NavBarButton(onTap: () {}, text: 'Home'),
                // NavBarButton(onTap: () {}, text: 'Features'),
                // NavBarButton(onTap: () {}, text: 'Screenshots'),
                // NavBarButton(onTap: () {}, text: 'Contact'),
              ],
            ),
          ),
        ),
        Container(
          color: navBarColor,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  const FadeInImage(
                    placeholder: NetworkImage(
                        'https://media1.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif'),
                    width: 50,

                    // height: 40.0,
                    image: AssetImage("assets/logo.png"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Company Name",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87),
                  ),
                  Expanded(child: Container()),
                  Material(
                    child: InkWell(
                      splashColor: Colors.white60,
                      onTap: () {
                        containerHeight.value = height;
                        /*esta funcion lo que me dice que [containerHeight.value == height]
                      y solo va a liberarse o activarse o 'mostrarse' cuando le de tap, y la logica
                      detras de esto es lo siguiente:

                      'containerHeight' tiene un valor inicial de 0;
                      
                      'height' tiene un [valor condicional] que dice:
                      - que si el valor de containerHeight es 0(que inicialmente lo es) 
                      entonces el valor de containerHeight va cambiar a 240;

                      La cosa es que una vez que se cumple esa funcion de que si el valor de containerHeight es 0
                      entonces su valor va a cambiar a 240 solo seria algo estatico, es como que si la funcion
                      ya estuviese accionada y listo, lo que hago con el onTap es que si aprieto una vez
                      la funcion se ejecuta, y ahi teniendo el valor de 240 es que se aplica la segunda condicion
                      del valor de height.
                      
                      Segunda condicion[valor 'height']:
                      Dice que si el valor de containerHeight es > 0, entonces su valor va a cambiar a 0, 
                      por tener un valor mayor a cualquier numero superior a 0. Y esa funcion solo se va
                      a ejecutar (asi como escribi arriba) por el hecho de yo dar tap 
                       
                       */
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.black54,
                      ),
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}
