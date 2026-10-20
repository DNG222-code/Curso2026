const dias = {
    Monday: "Dilluns",
    Tuesday: "Dimarts",
    Wednesday: "Dimecres",
    Thursday: "Dijous",
    Friday: "Divendres",
}

function myFunction() {
    const horaActual = new Date();
    const horaMinima = 6;

    for (let fila = 3; fila < sheet.getLastRow(); fila++) {
        const horaGuardia = sheet.getRange(fila, 1).getValue();
        if (horaGuardia.Date.getHours() === horaMinima) {
            copiarGuardias();
        }


}

    function copiarGuardias() {
        const gs = SpreadsheetApp.getActiveSpreadsheet();

        const origen = gs.getSheetByName("Dilluns");
        const destino = gs.getSheetByName("AVUI");
    }
}