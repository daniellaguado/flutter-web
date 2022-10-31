import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:website/src/content/content.dart';
import 'package:website/src/navigation_bar/nav_bar.dart';
//! Coloqué el navigation_bar/nav_bar.dart, ya lo tenia pero bueno se agregó de nuevo
import 'navigation_bar/nav_bar.dart';

final homeKey = GlobalKey();
final featureKey = GlobalKey();
final screenshotKey = GlobalKey();
final contactKey = GlobalKey();
/* 
! Posible error que solucioné, hay que intentar colocarlo de nuevo a ver qlq
! en el currentPageProvider le quite dos parentesis al final en la función del GlobalKey => homeKey
*/
final currentPageProvider = StateProvider<GlobalKey>((_) => homeKey);
/* Creó un provider para conocer el estado actual, por defecto va a ser el de homekey*/

/*Este StateProvider es un gestor de estado que viene de flutter_hooks
por eso es que el widget de referencia que es pasado por el HookConsumer
vaya la redundancia es de los mismo hooks, y por eso es obvio que se llama
HooksConsumerWidget*/
//! Cambie el return por una funcion de flecha
final scrolledProvider = StateProvider<bool>((_) => false);
/* Este provider que tiene una variable boolena, si es true, significa que si
hay scroll, si es false significa que no hay scroll, por eso su valor incicial es false. 
"Super util!!" su aplicacion esta en el nav_bar.dart 
 */

class MyPageWeb extends HookConsumerWidget {
  const MyPageWeb({Key? key}) : super(key: key);

  /* Esta funcion lo que hace es que cuando pasamos el global key hace que esa sección o ese widget
  sea visible, o sea que al momento de dar click a cualquer link del menú va a ser que la sección a la que
  le di click me sea ivisble y la duración para llegar ahí sera de 500 milisegundos*/

  void onScroll(ScrollController controller, WidgetRef ref) {
    /* La referencia del widget que lee se encuentra es entre parentesis por ejemplo
      ref.read(scrolledProvider)*/
    final isScrolled = ref.read(scrolledProvider);
    /* Se guarda para poder usar el scrolledProvider en una variable isScrolled, que lo que hace
    es leer el widget de referencia que es el scrolledProvide, y una vez que ya hayamos concatenado
    el resultado con una variable es tiempo de usarla */

    if (controller.position.pixels > 5 && !isScrolled) {
      ref.read(scrolledProvider.state).state = true;
      /* Con el heco que se haga scroll ya cambia el provider de false a true, lo que en pocas palabras
      estoy haciendo aqui, es extender un poco el hecho del que el scrolledProvider se vuelva true, le 
      digo que se vuela true despues que hayan pasado > 5 px */
    } else if (controller.position.pixels <= 5 && isScrolled) {
      ref.read(scrolledProvider.state).state = false;
      /* 
    primeramente se puede leer asi: se pide recibir un argumento llamado scroller, y un widget de referencia
    si ese argumento con su posicion en pixeles es mayor a 5px y el isScrolled esta en true, entonces 
    la referencia a ese widget que es una referencia recibida tambien por argumento va a ser leida y cambiará
    su estado a true;

    Explicando lo siguiente: 
    se crea una condicion que dice que el 'controller', que es el argumento y mandado como referencia, que 
    es de tipo ScrollController, se utiliza la propiedad de: posicion en pixeles, si es mayor a 5 px y 
    hay scroll. o sea que !isScrolled es diferente, bien se sabe que isScrolled es false, bueno cuando sea 
    diferente a eso, significa que hay scroll, entoces la condicion es: que si se mueve 5px y hay scroll 
    entonces{})

    Entonces si la posicion es mayor a 5px y hay escroll{
      - se lee la referencia del estado del provider y se le cambia el estado a true;
      - tambien si, la posion del scrollcontroller en pixeles es menor a 5 y isCrolled esta en false
      significa que no ha habido movimiento con scroll en la pagina, eso quiere decir entonces
      que se lee la refere del widget eque en este caso es el scrolledProvider y su estado sera igual a false
    }
     */

      /* Vuelvo a utilizar un HookconsumerWidget para no utilizar
  un StatefullWidget, y asi poder utilizar el controller */
    }
  }

  void scrollTo(GlobalKey key) => Scrollable.ensureVisible(key.currentContext!,
      duration: const Duration(milliseconds: 500));

//Ahora si se empieza a sobreescribir el build para comenzar a construir la screen
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController _controller = useScrollController();

    useEffect(() {
      _controller.addListener(() {
        return onScroll(_controller, ref);
/*
Segun estoy entendiendo:

se manda a usar el efecto: -> useEffect(() {      [es hook]
en el efecto se dice que se va a escuchar al _controller, que es un ScrollController y que me dice
cual es la ruta inicial del scroll que por default está en 0.0
Ese _controller es escuchado y retorna el void onScroll y manda como argumento de tipo ScrollController
al _controller, y de referencia agarra la referencia del scrollProvider, o no la usa, no se todavia, el caso
es que eso pedia la funcion onScroll.

retorna el _controller.dispose que lo que hace es descartar cualquier recurso utilizado por el objeto, lo borra,
despues de llamar ese metodo el objeto no puede utilizarse mas y debe descartarse, en pocas palabras borra el 
estado.  Todavia no se exactamente cual seria el proposito

 */
      });
      return _controller.dispose;
    }, [_controller]
        //La verdad todavia no se para que se usa esto el [_controller] , ya que se puede borrar
        // y no sucede nada
        );

    double width = MediaQuery.of(context).size.width;
    //para saber el ancho total de la pagina
    double maxWidth = width > 1200 ? 1200 : width;
    /* La logica aqui es la siguiente: si el width es mayor a 1200 px de resolucion
    de pantalla, entonces coloca 1200, sino es mayor a 1200 entonces utiliza el width normal
    de cada resolucion, esa condicion solo se aplica cuando es mayor, y se le agrega al container */

    /* Esto aqui es un listener para el provider que ya habia creado de currentPageProvider que inicialmente
es homeKey */
    ref
        .watch(currentPageProvider.state)
        .addListener(scrollTo, fireImmediately: false);
    /* Esta funcion lo que me dice es: 
       Cada vez que cambia el estado de mi currentPageProvider voy a llamar la funcion
       scrollTo.
       Se colocó fireImmediately: false, para que la primera vez no se ejecute el listener, ya que la primera
       vez vamos a estar en la sección del home
       */

    return Scaffold(
      body: Center(
          child: Container(
        width: maxWidth,
        child: Column(
          children: [
            const NavBar(),

            /* el navigationbar esta fuera del singlechild porque cuando se haga escroll
            solo se va a mover el contenido el menu va a estar fijo */
            Expanded(
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  children: <Widget>[
                    HomeContent(key: homeKey),
                    FeaturesContent(key: featureKey),
                    ScreenshotContent(key: screenshotKey),
                    ContactContent(key: contactKey),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
