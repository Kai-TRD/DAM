
// var account = {
//     username: "",
//     email: "",
//     password: "",
//     notification: false,
//     tyc: false,
// }

// var username = document.getElementById("username");
// var email = document.getElementById("email");
// var password = document.getElementById("password");
// var notification = document.getElementById("notification");
// var tyc = document.getElementById("tyc");

document.addEventListener('DOMContentLoaded', function () {
    var form = document.querySelector('form');
    form.addEventListener('submit', function (event) {
        event.preventDefault();

        // guardar el userName
        var nombreUsuarioElemento = document.getElementById('nombreUsuario');
        var prueba = document.getElementById('javascriptForm');


        // obtener valores del form
        var username = document.getElementById('username').value;
        var email = document.getElementById('email').value;
        var password = document.getElementById('password').value;
        var passwordRepit = document.getElementById('passwordRepit').value;
        var tycCheckbox = document.getElementById('tyc');

        // comprobaciones
        if (!username || !email || !password || !passwordRepit) {
            alert('Por favor, complete todos los campos del formulario.');
            return;
        }

        if (password !== passwordRepit) {
            alert('Las contraseñas no coinciden.');
            return;
        }

        if (!tycCheckbox.checked) {
            alert('Debe aceptar los términos y condiciones.');
            return;
        }


        var account = {
            username: username,
            email: email,
            password: password,
            // notification: false,
            // tyc: tycCheckbox,
        };

        // alert(prueba)

        var prueba = JSON.stringify(account);
        document.getElementById('jsonContainer').textContent = prueba;

        nombreUsuarioElemento.textContent = username;
        var elementoValido = document.querySelector('.valido');
        elementoValido.style.display = 'block';

        form.reset();
    });
});
