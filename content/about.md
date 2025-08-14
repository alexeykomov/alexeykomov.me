---js
const eleventyNavigation = {
	key: "About",
	order: 4
};
---
# About

<picture>
<source type="image/webp" srcset="/img/avatar1x.webp 1x, /img/avatar1.5x.webp 1.5x, /img/avatar2x.webp 2x, /img/avatar3x.webp 3x">
<source type="image/jp2" srcset="/img/avatar1x.jp2 1x, /img/avatar1.5x.jp2 1.5x, /img/avatar2x.jp2 2x, /img/avatar3x.jp2 3x">
<source type="image/jpeg" srcset="/img/avatar1x.jpg 1x, /img/avatar1.5x.jpg 1.5x, /img/avatar2x.jpg 2x, /img/avatar3x.jpg 3x">
<img src="/img/avatar1x.jpg" alt="Alexey avatar" class="avatar" style="width: 150px; height: 150px; border-radius: 50%; margin-bottom: 1rem;">
</picture>

Hello, my name is Alexey, I'm a front-end developer, currently working for [EPAM](https://www.epam.com).

I'm also the author of [Reflect Calendar](https://reflectcal.com), a fast and minimalist web-calendar.

My passions include:

1. Web.
2. Large web-applications, yet with simple UI.
3. Performance.
4. Simplicity.
5. Challenging problems on the edge of what is possible in Web platform.

Personal interests include, among other, traveling, books and music.

Here's my [GitHub profile](https://github.com/alexeykomov/).

I occasionally blog here at [Medium](https://medium.com/reflecting-on-bits).

Here's my [resume](https://alexeykomov.github.io/resume/resume.pdf).

Feel free to contact me by <a href="#" id="mail-link-about">e-mail</a>.

<script>
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('mail-link-about').href = ['mailto:',
            'alexeykcontact', '@', 'gmail', '.', 'com'].join('');
});
</script>
