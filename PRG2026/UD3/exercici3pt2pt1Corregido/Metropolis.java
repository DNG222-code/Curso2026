package exercici3pt2pt1Corregido;

public class Metropolis {

    public static void main(String[] args) {

        // Declaració de variables.
        boolean esCapital = true; // Cert si la ciutat és capital.
        int nombreDeCiutadans = 51000; // Nombre de ciutadans de la ciutat.
        double impostPerCiutada = 190; // Impost mitjà mensual.
        boolean esMetropolis; // Determina si una ciutat es metrópolis.

        // Montem la expressió que determina si una ciutat es metrópolis.
        esMetropolis = (esCapital && nombreDeCiutadans > 100000)
                || (nombreDeCiutadans > 200000 && (nombreDeCiutadans * impostPerCiutada * 12) > 720000000);

        System.out.println(esMetropolis ? "Sí" : "No");

    }
}