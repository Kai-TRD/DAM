// Visualizacio/modicficación/borrado de fichero json

var planetaJSON = {
    "nombre": "Tierra",
    "numero": 3,
    "radio": 5371,
    "habitable": true,
    "tieneAnillos": false,
    "continentes": { /*este atributo del objeto "planetaJSON* es, a su vez, un objeto*/
        "contienente1": "Afrika",
        "contienente2": "Amérika",
        "contienente3": "Antártida",
        "contienente4": "Asia",
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

planetaJSON.continentes.contienente1 = "Africa";
planetaJSON.continentes.contienente2 = "América";

var x;
for (x in planetaJSON.continentes) {
    document.getElementById("conPla").innerHTML += planetaJSON.continentes[x] + ", ";
}

// Borrado de uno de sus atrinutos
delete planetaJSON.continentes.contienente2;
document.getElementById("conPla").innerHTML = "";

for (x in planetaJSON.continentes) {
    document.getElementById("conPla").innerHTML += planetaJSON.continentes[x] + ", ";
}
// ********************************************************************
// * Utilización de las funcuones "JSON.stringify()" y "JSON.parse()" *
// ********************************************************************

// Declaracion del ibheto JS "planetaJS"

var planetaJS = {
    nombre: "Tierra",
    numero: 3,
    radio: 6371,
    tieneAnillos: false,
    habitable: true,

};

// coversion del objeto JS en un string JSON

var stringJSON = JSON.stringify(planetaJS);
console.log(stringJSON)

// coversion de un string JSON a un objeto JS 

var onjectJS = JSON.parse(stringJSON);
console.log(onjectJS)