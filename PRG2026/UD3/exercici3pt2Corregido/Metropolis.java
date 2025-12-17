package exercici3pt2Corregido;

public class Metropolis {

    public static void main(String[] args) {

        // Declaració de variables.
        boolean esCapital = true; // Cert si la ciutat és capital.
        int nombreDeCiutadans = 51000; // Nombre de ciutadans de la ciutat.
        double extensio = 190; // Extensió de la ciutat en km2.
        boolean esMetropolis; // Determina si una ciutat es metrópolis.

        // Montem la expressió que determina si una ciutat es metrópolis.
        esMetropolis = (esCapital && (nombreDeCiutadans > 50000) && (extensio > 100)) ||
                (nombreDeCiutadans > 100000);

        System.out.println(esMetropolis ? "Sí" : "No");

    }

}