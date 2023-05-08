import java.util.Scanner;

public class PRUEBA {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        System.out.println("Introduzca un numero entero (mayor que zero): ");
        int numeroIntroducido = Integer.parseInt(s.nextLine());

        int numero = numeroIntroducido;
        int volteado = 0;
        boolean numeroComido = false;

        // Al mismo tiempo que se le d la vuelta al numero
        // se le quitan los 0s y 8s
        while (numero > 0) {
            if ((numero % 10 != 0) && (numero % 10 != 8)) {
                volteado = (volteado * 10) + (numero % 10);
            } else {
                numeroComido = true;
            }
            numero /= 10;
        }
 
        // Se le vuelve a dar la vuelta al numero
        numero = volteado;
        volteado = 0;

        while (numero > 0) {
            volteado = (volteado * 10) + (numero % 10);
            numero /= 10;
        }

        if (numeroComido) {
            System.out.println("Despues de haber sido comido por el gusano numerico");
            System.out.println(" se queda en " + volteado + ".");
        } else {
            System.out.println("El gusano numerico no se ha comido ningun digito");
        }
    }
}

/*
 *  +----(1)----> [Scanner s = new Scanner(System.in);]
    |
    +----(2)----> [System.out.println("Introduzca un numero entero (mayor que zero): ");]
    |
    +----(3)----> [int numeroIntroducido = Integer.parseInt(s.nextLine());]
    |
    +----(4)----> [int numero = numeroIntroducido;]
    |
    +----(5)----> [int volteado = 0;]
    |
    +----(6)----> [boolean numeroComido = false;]
    |
    +----(7)----> [while (numero > 0) {]
    |        |    
    |        +----(8)----> [if ((numero % 10 != 0) && (numero % 10 != 8)) {]
    |        |        |    
    |        |        +----(9)----> [volteado = (volteado * 10) + (numero % 10);]
    |        |        |    
    |        |        +----(10)--> [} else {]
    |        |                 |    
    |        |                 +----(11)--> [numeroComido = true;]
    |        |                 |    
    |        |                 <--------+
    |        |    
    |        +----(12)--> [numero /= 10;]
    |        |    
    |        <--------+
    |
    +----(13)--> [numero = volteado;]
    |
    +----(14)--> [volteado = 0;]
    |
    +----(15)--> [while (numero > 0) {]
    |        |    
    |        +----(16)--> [volteado = (volteado * 10) + (numero % 10);]
    |        |    
    |        +----(17)--> [numero /= 10;]
    |        |    
    |        <--------+
    |
    +----(18)--> [if (numeroComido) {]
    |        |    
    |        +----(19)--> [System.out.println("Despues de haber sido comido por el gusano numerico");]
    |        |    
    |        +----(20)--> [System.out.println(" se queda en " + volteado + ".");]
    |        |    
    |        <--------+
    |
    +----(21)--> [else {]
             |    
             +----(22)--> [System.out.println("El gusano numerico no se ha comido ningun digito");]
             |    
             <--------+

 */