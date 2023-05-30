const noticias = document.querySelectorAll('.noticia');

noticias.forEach(noticia => {
    noticia.addEventListener('click', function() {
        noticia.classList.toggle('grande');
    });
});