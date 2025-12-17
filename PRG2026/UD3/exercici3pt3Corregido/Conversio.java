package exercici3pt3Corregido;

import java.util.Scanner;

public class Conversio {

    public static void main(String[] args) {

        // Declaració de variables.
        double milles = 0;
        double quilometres = 0;
        final double FACTOR_MQ = 1.60934; // Factor conversió millas a quilometres.

        // Instanciem un Scanner per interaccionar amb l'Usuari.
        Scanner sc = new Scanner(System.in);

        // Demanem les milles a l'usuari.
        System.out.println("Introdueix la distància en milles: ");
        // Recollim la dada de l'usuari.
        milles = sc.nextDouble();

        // Feim la conversió.
        quilometres = milles * FACTOR_MQ;

        // Mostrem el resultat.
        System.out.println(milles + " milles equivalen a " + quilometres + " quilometres");

        // Tanquem el Scanner:
        sc.close();

    }

}