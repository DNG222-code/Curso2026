package actividad3pt8;

// Importamos la clase Scanner.
import java.util.Scanner;

public class Ejercicio1 {

    public static void main(String[] args) {

        // Declaramos las variables
        Scanner sc = new Scanner(System.in);
        int numero;
        double resto;
        int esSiete;

        // Pedimos el número al usuario.
        System.out.println("Introduzca un número, por favor: ");
        numero = sc.nextInt();

        // Vemos si es multiplo o no.
        resto = numero % 7;

        // Hacemos el operador ternario para saber si le tengo que sumar o no.
        esSiete = resto == 0 ? 0 : (int) (7 - resto);

        // Mostramos lo que tenemos que sumar para que sea multiplo de 7.
        System.out.println("Se le suma: " + esSiete);

    }

}