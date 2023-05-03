
var planetaJSON = {
    "nombre": "Tierra",
    "numero": 3,
    "radio": 5371,
    "habitable": true,
    "tieneAnillos": false,
    "continentes": { /*este atributo del objeto "planetaJSON* es, a su vez, un objeto*/
        "contienente1": "Asia",
        "contienente2": "Amérika",
        "contienente3": "Afrika",
        "contienente4": "Antártida",
    }

}

// Visualizacion de algnos de sus atributos declarados, preciamente, las correspondientes variables
var nomPla = planetaJSON.nombre;
var radPLa = planetaJSON.radio;
var habPla = planetaJSON["habitable"];

document.getElementById("nomPla").innerHTML = nomPla;
document.getElementById("radPla").innerHTML = radPLa;

if (habPla) {
    document.getElementById("habPla").innerHTML = "Si";
} else {
    document.getElementById("habPla").innerHTML = "No";
}

document.getElementById("numPla").innerHTML = planetaJSON.numero;

planetaJSON.radio = 6371;
document.getElementById("radPla").innerHTML = planetaJSON.radio;

planetaJSON.continentes.contienente2 = "América";
planetaJSON.continentes.contienente3 = "Africa";

var x;
for (x in planetaJSON.continentes) {

    document.getElementById("conPla").innerHTML += planetaJSON.continentes[x] + ", ";
}
