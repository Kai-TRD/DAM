package Examen;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;

public class Ejercicio2 {
    public static void main(String[] args) {
        
        /*
         *  Crea una fecha utilizando números aleatorios, ten cuidado de que sea una fecha correcta.

            Muestra dicha fecha con el formato : "Es el día 25 de Enero (Lunes) de 2022"
            Muestra los días que faltan para llegar al 31/12/ del año generado (31/12/xxxx)
         */

        int miDiaAleatoria = (int) Math.round(Math.random()*30);
        int miMesAleatoria = (int) Math.round(Math.random()*11);
        int miAnoAleatoria = (int) Math.round(Math.random()*30+2000);

        LocalDate miFecha = LocalDate.of(miAnoAleatoria, miMesAleatoria, miDiaAleatoria);
        System.out.println(miFecha);
        System.out.println("-----------------------------------------------");
        
        DateTimeFormatter miFormatoDeFecha = DateTimeFormatter.ofPattern("dd-MMMM-yyyy");
        
        System.out.println(miFecha.format(miFormatoDeFecha));

        System.out.println("-----------------------------------------------");

        LocalDate finDeAno = LocalDate.of(miAnoAleatoria, 12, 31);
        Period transcurrido = Period.between(miFecha, finDeAno);

        int numeroDias = transcurrido.getDays();

        System.out.println("Quedan para fin de año " + numeroDias + "días");
    }
}
