import 'package:flutter/material.dart';

mixin ElevatedNavigationBar<T extends StatefulWidget> on State<T>{
  //se mantienen como late para que el usuario pueda tener el control
  int index = 0;
  PageController pageController = PageController();

  PageController init() => PageController(initialPage: index);
  //Los parametros son para especificar si se quiere
  //comenzar desde otro boton en el navigation bar
  void buildLateNavBar({int? firstIndex, PageController? controller}) {
    index = firstIndex ?? index;
    pageController = controller ?? init();
  }

  void becomeListener() {
    pageController.addListener(() {
      if (pageController.page?.round() != index) {
        index = pageController.page!.round();
      }
    });
  }

  Container createNavBar({
    EdgeInsets? padding,
    double? iconSize,
    required buttonList,
  }) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
          if (value != index) {
            setState(() {
              index = value;
              pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic);
            });
          }
        },
          iconSize: iconSize ?? 24,
          items: buttonList,
        ),
      ),
    );
  }


}
