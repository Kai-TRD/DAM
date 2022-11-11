package Examen;

import java.util.Scanner;

public class Ejercicio1 {
    public static void main(String[] args) {
    /*
     *  Dado el siguiente texto:
        "Crearía un perfume que no sólo fuera humano, sino sobrehumano. Un aroma de ángel, tan indescriptiblemente 
        bueno y pletórico de vigor que quien lo oliera quedaría hechizado y no tendría más remedio que amar a la persona 
        que lo llevara, o sea, amarle a él, Grenouille, con todo su corazón (El Perfume, Patrick Süskind)"

    Debes:
    a) Encontrar el caracter que se encuentra en una posición aleatoria. Si es un espacio mostrar espacio.
    b) Leer un caracter y reemplar todas las apariciones de 'a' por este nuevo caracter.
    c) Indica al usuario que indique una palabra y busca dicha palabra en el texto. El programa debe indicar si está o no 
       dicha palabra en el texto. Debe de no distinguir entre mayusculas y minúsculas
     */


    String cadena = "Crearía un perfume que no sólo fuera humano, sino sobrehumano. Un aroma de ángel, tan indescriptiblemente bueno y pletórico de vigor que quien lo oliera quedaría hechizado y no tendría más remedio que amar a la persona que lo llevara, o sea, amarle a él, Grenouille, con todo su corazón (El Perfume, Patrick Süskind)";
    
    int longitudTotal = cadena.length();

    double random1 = Math.random()*longitudTotal;
    int random2 = (int) Math.round(random1);
    System.out.println(random2);
    System.out.println("Palabra al azar: "+cadena.charAt(random2));
    
    System.out.println("---------------------------------------------------------------");
    Scanner sc = new Scanner(System.in);

    System.out.println("Escribeme un caracter para remplazar todas las a");
    String caracter1 = sc.nextLine();
    
    //Reemplazar
    System.out.println(cadena.replace("a", caracter1));
     
    System.out.println("---------------------------------------------------------------");

    System.out.println("Dime una palabra que busque en el texto");
    String palabra = sc.nextLine();

    boolean buscar1 = cadena.contains(palabra);

    System.out.println((buscar1==true)? "La palabra esta en el texto": "La palabra NO esta en");

    sc.close();
    }
}
