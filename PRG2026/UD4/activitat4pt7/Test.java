package activitat4pt7;

import java.util.Scanner; // Importamos la clase Scanner.

public class Test {

    public static void main(String[] args) {

        // Declaramos las variables
        Scanner sc = new Scanner(System.in);

        // Variable para el número.
        int binario;

        // Declaramos la variable para el resto.
        int resto;

        // Declaramos la variable para la potencia.
        int potencia = 0;

        // Variable para el decimal.
        int decimal = 0;

        // Pedimos el número al usuario.
        System.out.println("Introduce un número binario, por favor: ");
        binario = sc.nextInt(); // Guardamos el número en (n).

        // Cálculo de binario a decimal.
        while (binario > 0) {
            resto = binario % 10; // Sacamos la última cifra.

            // Comprobamos de que sea un número aleatorio.
            if (resto == 1) {
                decimal += (int) Math.pow(2, potencia); // Guardamos el cálculo de la potencia en la variable decimal.

            } else if (resto != 0) {
                System.out.println("ERROR: No es un número binario.");

            }

        }

        // Imprimimos el número decimal.
        System.out.println(decimal);

        // Dibujamos el triángulo
        for (int i = binario; i >= 1; i--) {
            for (int j = 0; j < i; j++) {
                System.out.print("*"); // Sin salto de línea

            }
            System.out.println(); // Salto de línea al final de cada fila
        }

        sc.close();
    }

}