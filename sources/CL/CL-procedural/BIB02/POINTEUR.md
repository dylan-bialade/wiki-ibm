---
bibliotheque: BIB02
fichier_source: QCLSRC
membre: POINTEUR
type: CL/CL-procedural
longueur_enregistrement: 100
lignes: 18
modifie: 2026-11-16
---

# BIB02/QCLSRC/POINTEUR

```cl
#include <stdio.h>

int main(void) {
    // Exemple simple d'utilisation de pointeurs en C
    int a = 42;
    int* ptr = &a; // Pointeur qui stocke l'adresse de 'a'

    printf("Valeur de a: %d\n", a);
    printf("Adresse de a: %p\n", (void*)&a);
    printf("Valeur du pointeur ptr: %p\n", (void*)ptr);
    printf("Valeur pointée par ptr: %d\n", *ptr);

    // Modifier la valeur de 'a' via le pointeur
    *ptr = 100;
    printf("Nouvelle valeur de a: %d\n", a);

    return 0;
}
```
