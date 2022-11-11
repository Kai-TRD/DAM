package Examen;

import java.util.Scanner;

public class Ejercicio3 {
    public static void main(String[] args) {
        
        /*
         *  Quiero saber si puedo comprarme un piso y para ello debo de pedir una hipotecaal banco.
            El banco me pone una serie de condiciones: tener trabajo fijo y tener cuenta con ellos,
            si no tengo trabajo fijo entonces debo tener cuenta con ellos y tener ahorrado mas del
            20% del importe del piso. La última opción para que me den la hipoteca es tener 50% del
            valor del piso ahorrado.

            Realiza un programa que pregunte las  diferentes cuestiones que necesito saber y me
            diga si el banco me daría o no la hipoteca.

            Realiza el ejercicio utilizando el operador ternario.
         */
        Scanner sc = new Scanner(System.in);

         System.out.println("¿Tienes trabajo fijo?(s/n)");
         String trabajo = sc.nextLine();

         System.out.println("¿Tienes cuenta del banco?(s/n)");
         String cuenta = sc.nextLine();

         System.out.println("¿Tienes ahorrado mas del 20% del importe del piso?(s/n)");
         String ahorrado20 = sc.nextLine();

         System.out.println("¿Tienes 50% del valor del piso ahorrado?(s/n)");
         String ahorrado50 = sc.nextLine();
         
        System.out.println("Forma1");
        
        System.out.println((trabajo == "s" && cuenta == "s") ? "Puedes tener hipoteca" : "No puedes tener hipoteca");
         

    }
}
