---
title: My website redesign
description: "I've redesigned my website to include all of the open source projects I did. Also my older posts from Medium were ported here, so this would be the new place for my blog."
date: 2025-09-03
tags: eleventy, static site, web development, hosting, netlify, picture tag, meta
---

On the 1st of September I've finally updated my website at [alexeykomov.me](https://alexeykomov.me)! As you're reading this, you are already seeing this work in production 🙃.

<figure>
  <picture>
    <source srcset="/img/site-now-mobile-300.avif 300w, /img/site-now-mobile-600.avif 600w, /img/site-now-mobile-900.avif 900w" type="image/avif" sizes="100vw">
    <source srcset="/img/site-now-mobile-300.webp 300w, /img/site-now-mobile-600.webp 600w, /img/site-now-mobile-900.webp 900w" type="image/webp" sizes="100vw">
    <source srcset="/img/site-now-mobile-300.png 300w, /img/site-now-mobile-600.png 600w, /img/site-now-mobile-900.png 900w" type="image/png" sizes="100vw">
    <img src="/img/site-now-mobile-600.png" alt="My website nowadays - on mobile" loading="lazy" decoding="async" width="300" sizes="(max-width: 300px) 300px, 100vw" srcset="/img/site-now-mobile-300.png 300w, /img/site-now-mobile-600.png 600w, /img/site-now-mobile-900.png 900w">
  </picture>
  <figcaption>My website nowadays - on mobile.</figcaption>
</figure>

<figure>
  <picture>
    <source srcset="/img/site-now-desktop-1000.avif 1000w, /img/site-now-desktop-2000.avif 2000w, /img/site-now-desktop-3000.avif 3000w" type="image/avif" sizes="(min-width: 928px) 928px, 100vw">
    <source srcset="/img/site-now-desktop-1000.webp 1000w, /img/site-now-desktop-2000.webp 2000w, /img/site-now-desktop-3000.webp 3000w" type="image/webp" sizes="(min-width: 928px) 928px, 100vw">
    <source srcset="/img/site-now-desktop-1000.png 1000w, /img/site-now-desktop-2000.png 2000w, /img/site-now-desktop-3000.png 3000w" type="image/png" sizes="(min-width: 928px) 928px, 100vw">
    <img src="/img/site-now-desktop-1000.png" alt="My website nowadays - on desktop" loading="lazy" decoding="async" width="1000" sizes="(min-width: 928px) 928px, 100vw" srcset="/img/site-now-desktop-1000.png 1000w, /img/site-now-desktop-2000.png 2000w, /img/site-now-desktop-3000.png 3000w">
  </picture>
  <figcaption>My website nowadays - on desktop.</figcaption>
</figure>

## Nostalgic vibes

Historically, I had my personal website present at that domain [a while ago](https://github.com/alexeykomov/alexeykomov.github.io/commit/e48cb9f8e38d523a02a8ee377b9891a2d873937c). I think it was inspired by [Anton Kovalev's personal website](https://antonkovalyov.com/), though I can't find the exact reference now. I remember it was stylistically simple yet pleasant website with an avatar placed in `border-radius: 50%` frame.

<figure>
  <picture>
    <source srcset="/img/site-before-300.avif 300w, /img/site-before-600.avif 600w, /img/site-before-900.avif 900w" type="image/avif" sizes="100vw">
    <source srcset="/img/site-before-300.webp 300w, /img/site-before-600.webp 600w, /img/site-before-900.webp 900w" type="image/webp" sizes="100vw">
    <source srcset="/img/site-before-300.png 300w, /img/site-before-600.png 600w, /img/site-before-900.png 900w" type="image/png" sizes="100vw">
    <img src="/img/site-before-600.png" alt="My website as it was" loading="lazy" decoding="async" width="300" sizes="(max-width: 300px) 300px, 100vw" srcset="/img/site-before-300.png 300w, /img/site-before-600.png 600w, /img/site-before-900.png 900w">
  </picture>
  <figcaption>My website as it was.</figcaption>
</figure>

I think the site served its purpose by providing the link to my resume and GitHub profile. I also remember at least one recruiter who contacted me after reading the website's invitation to send an email 😁. You can still visit the [old site](https://alexeykomov.github.io) if you're so inclined.

At the same time I blogged a little at Medium, which is the platform I sincerely liked then and continue to like now, despite the fact I don't read it often now. I think my initial love for Medium was inspired by the fact that it was built right in [front of my eyes](https://web.archive.org/web/20120505104659/http://obvious.com/) with the [technologies I like](https://developers.google.com/closure). I remember Dan Pupius wrote [the post](https://web.archive.org/web/20120516044651/http://pupius.co.uk/blog/) with the words

> the choice then was Obvious

and this is the point where I started to track the changes to the Medium platform. Extra value of the product built by notable ex-Googlers and other great engineers is that a lot of [insightful](https://writing.pupius.co.uk/gmail-and-the-gc-6b1ea3ffca45) [posts](https://medium.engineering/why-contenteditable-is-terrible-122d8a40e480) [appeared](https://medium.engineering/the-stack-that-helped-medium-drive-2-6-millennia-of-reading-time-e56801f7c492) there on engineering. I also loved how easy and pleasant from a UX perspective it was to put text using their UI.

Oh and by the way, Medium is a treasure trove for other engineering stories: take the one about font called ["System"](https://medium.design/system-shock-6b1dc6d6596f), for example. Did you play the remake of System Shock 2, by any chance?

Over time, however, I felt that I needed some place of my own to put my blog. This was falling nicely in the direction of [indie web articles](https://timmarinin.net/2019/indieweb/) I've read from Tim Marinin. But even more than that I wanted to have all things in one place - both list of the projects and the collection of posts.

## Tech stack

I was definitely thinking of the site as a bunch of static pages and static files. After all, what is the use of server code for me? Ironically, later I wanted to add likes👍 system for posts, which implies you need some [server code](https://docs.netlify.com/manage/routing/redirects/rewrites-proxies/#proxy-to-another-service) after all.
Having a little experience in working with [Radzima's landing page](https://github.com/radzima-green-travel/radzima.app) which was using [Eleventy](https://www.11ty.dev/), I chose Eleventy to be the base site platform for me.

### Pictures

I tried to use responsive images with the `<picture/>` tag as much as possible, here's the example of avatar, which is quite convoluted I admit - it uses even `jp2` format. I think the suggestion came from the [post by David Walsh](https://davidwalsh.name/how-to-use-jpeg-2000-jp2-for-a-faster-images-on-iphone) - at the time webp [wasn't supported in iOS](https://caniuse.com/webp).
```html
<picture>
<!-- Dark mode avatar -->
<source media="(prefers-color-scheme: dark)" type="image/webp" srcset="/img/avatar-dark-1x.webp 1x, /img/avatar-dark-1.5x.webp 1.5x, /img/avatar-dark-2x.webp 2x, /img/avatar-dark-3x.webp 3x">
<source media="(prefers-color-scheme: dark)" type="image/jp2" srcset="/img/avatar-dark-1x.jp2 1x, /img/avatar-dark-1.5x.jp2 1.5x, /img/avatar-dark-2x.jp2 2x, /img/avatar-dark-3x.jp2 3x">
<source media="(prefers-color-scheme: dark)" type="image/jpeg" srcset="/img/avatar-dark-1x.jpg 1x, /img/avatar-dark-1.5x.jpg 1.5x, /img/avatar-dark-2x.jpg 2x, /img/avatar-dark-3x.jpg 3x">

<!-- Light mode avatar (default) -->
<source type="image/webp" srcset="/img/avatar1x.webp 1x, /img/avatar1.5x.webp 1.5x, /img/avatar2x.webp 2x, /img/avatar3x.webp 3x">
<source type="image/jp2" srcset="/img/avatar1x.jp2 1x, /img/avatar1.5x.jp2 1.5x, /img/avatar2x.jp2 2x, /img/avatar3x.jp2 3x">
<source type="image/jpeg" srcset="/img/avatar1x.jpg 1x, /img/avatar1.5x.jpg 1.5x, /img/avatar2x.jpg 2x, /img/avatar3x.jpg 3x">
<img src="/img/avatar1x.jpg" alt="Alexey avatar" class="avatar" style="width: 300px; height: 300px; border-radius: 50%; margin-bottom: 1rem;">
</picture>
```

And another example of cover picture:
```html
<picture>
  <source
    type="image/avif"
    srcset="/img/reflect-cover-1000.avif 1000w,
            /img/reflect-cover-2000.avif 2000w,
            /img/reflect-cover-3000.avif 3000w"
    sizes="(min-width: 928px) 928px, 100vw" />

  <source
    type="image/webp"
    srcset="/img/reflect-cover-1000.webp 1000w,
            /img/reflect-cover-2000.webp 2000w,
            /img/reflect-cover-3000.webp 3000w"
    sizes="(min-width: 928px) 928px, 100vw" />

  <source
    type="image/png"
    srcset="/img/reflect-cover-1000.png 1000w,
            /img/reflect-cover-2000.png 2000w,
            /img/reflect-cover-3000.png 3000w"
    sizes="(min-width: 928px) 928px, 100vw" />

  <img
    src="/img/reflect-cover-1000.png"
    alt="Reflect Calendar cover"
    width="1000"
    height="574"
    srcset="/img/reflect-cover-1000.png 1000w,
            /img/reflect-cover-2000.png 2000w,
            /img/reflect-cover-3000.png 3000w"
    sizes="(min-width: 928px) 928px, 100vw" />
</picture>
```
Wow, that's quite a snippet! Important part here is that we aim for specific picture widths and when that width condition is satisfied, a proper format/size combination is served to the user. Attribute `sizes` may contain media queries for the viewport.

By the way, looking at the avatar picture snippet, you can see that I've taken advantage of media query to change the image source according to the dark mode, this is one of the gimmicks of the redesign.

<figure>
<video autoplay loop muted playsinline style="width:100%; max-width:300px;">
  <source src="/videos/dark-mode.webm" type="video/webm">
  <source src="/videos/dark-mode.mp4" type="video/mp4">
</video>
<figcaption>Different source for dark mode.</figcaption>
</figure>

For the rest of the pictures it's at most the triad of `avif`, `webp` and either `jpg` or `png` fallback (no `jp2` anymore). There are a few vector images as well.
These commands can be handy for format conversion:
```sh
#AVIF versions:
magick public/img/site-comparison.png -resize 300x -quality 60
public/img/site-comparison-300.avif
magick public/img/site-comparison.png -resize 600x -quality 60
public/img/site-comparison-600.avif
magick public/img/site-comparison.png -resize 900x -quality 60
public/img/site-comparison-900.avif

#WebP versions:
magick public/img/site-comparison.png -resize 300x -quality 60
public/img/site-comparison-300.webp
magick public/img/site-comparison.png -resize 600x -quality 60
public/img/site-comparison-600.webp
magick public/img/site-comparison.png -resize 900x -quality 60
public/img/site-comparison-900.webp
```

#### Composite images

One of the pleasant surprises I've discovered during this work is the composite images. When putting several thin screenshots in a line, it's actually really nice to have single composite image out of them - it's way easier to account for in markup. Here's Image Magick command that can do this for you:
```sh
magick public/img/site-before.png public/img/site-after.png
  +append public/img/site-comparison.png
```
This is the command that was used to make comparison image of this site's state before and after redesign.

### Formulae

One of the [posts](https://alexeykomov.me/blog/momentum-scrolling/) features formulae in it. I love the idea of using MathML directly on the page nowadays, it wasn't always like this - I still remember that standard working in Firefox but not in Chrome.
<figure>
  <picture>
    <source type="image/avif" srcset="/img/firefox-mathml-300.avif 300w, /img/firefox-mathml-600.avif 600w, /img/firefox-mathml-900.avif 900w" sizes="100vw">
    <source type="image/webp" srcset="/img/firefox-mathml-300.webp 300w, /img/firefox-mathml-600.webp 600w, /img/firefox-mathml-900.webp 900w" sizes="100vw">
    <source type="image/png" srcset="/img/firefox-mathml-300.png 300w, /img/firefox-mathml-600.png 600w, /img/firefox-mathml-900.png 900w" sizes="100vw">
    <img src="/img/firefox-mathml-600.png" alt="Early support of MathML in Firefox" loading="lazy" decoding="async" width="600" sizes="(max-width: 600px) 100vw, 600px" srcset="/img/firefox-mathml-300.png 300w, /img/firefox-mathml-600.png 600w, /img/firefox-mathml-900.png 900w">
  </picture>
  <figcaption>Early support of MathML in Firefox.</figcaption>
</figure>

Hence I have raster image fallbacks for the formulae. Let's test the browser you're in! You should see the [mass-energy equivalence equation](https://en.wikipedia.org/wiki/Mass%E2%80%93energy_equivalence#Low-speed_approximation) below if your browser supports MathML.

<figure>
    <math xmlns="http://www.w3.org/1998/Math/MathML" display="block" class="formula-small">
        <mrow>
       	<mi>E</mi>
       	<mo>≈</mo>
       	<msub><mi>m</mi><mn>0</mn></msub>
       	<msup><mi>c</mi><mn>2</mn></msup>
       	<mo>+</mo>
       	<mrow>
      		<mfrac><mn>1</mn><mn>2</mn></mfrac>
      		<msub><mi>m</mi><mn>0</mn></msub>
      		<msup><mi>v</mi><mn>2</mn></msup>
      		<mo>(</mo>
      		<mrow>
     			<mn>1</mn>
     			<mo>+</mo>
     			<mfrac>
        				<mrow>
       					<mn>3</mn>
       					<msup><mi>v</mi><mn>2</mn></msup>
        				</mrow>
        				<mrow>
       					<mn>4</mn>
       					<msup><mi>c</mi><mn>2</mn></msup>
        				</mrow>
     			</mfrac>
      		</mrow>
      		<mo>)</mo>
       	</mrow>
        </mrow>
    </math>
    <figcaption>The mass-energy equivalence equation.</figcaption>
</figure>

#### Small side quest with parentheses

It's actually funny that after I tested the formula in Firefox desktop and iOS Safari results were different and it's Firefox who wasn't correct. Web development, right?
The formula I used initially was using `<mfenced>` tag.
```xml
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
		<mrow>
		<mi>E</mi>
		<mo>≈</mo>
		<msub><mi>m</mi><mn>0</mn></msub>
		<msup><mi>c</mi><mn>2</mn></msup>
		<mo>+</mo>
		<mrow>
				<mfrac><mn>1</mn><mn>2</mn></mfrac>
				<msub><mi>m</mi><mn>0</mn></msub>
				<msup><mi>v</mi><mn>2</mn></msup>
				<mfenced open="(" close=")">
				<mrow>
						<mn>1</mn>
						<mo>+</mo>
						<mfrac>
						<mrow>
								<mn>3</mn>
								<msup><mi>v</mi><mn>2</mn></msup>
						</mrow>
						<mrow>
								<mn>4</mn>
								<msup><mi>c</mi><mn>2</mn></msup>
						</mrow>
						</mfrac>
				</mrow>
				</mfenced>
		</mrow>
		</mrow>
</math>
```
<figure>
    <picture>
        <source media="(prefers-color-scheme: dark)" type="image/avif" srcset="/img/formula-wrong-dark-300.avif 300w, /img/formula-wrong-dark-600.avif 600w, /img/formula-wrong-dark-900.avif 900w" sizes="100vw">
        <source media="(prefers-color-scheme: dark)" type="image/webp" srcset="/img/formula-wrong-dark-300.webp 300w, /img/formula-wrong-dark-600.webp 600w, /img/formula-wrong-dark-900.webp 900w" sizes="100vw">
        <source media="(prefers-color-scheme: dark)" type="image/png" srcset="/img/formula-wrong-dark-300.png 300w, /img/formula-wrong-dark-600.png 600w, /img/formula-wrong-dark-900.png 900w" sizes="100vw">
        <source type="image/avif" srcset="/img/formula-wrong-300.avif 300w, /img/formula-wrong-600.avif 600w, /img/formula-wrong-900.avif 900w" sizes="100vw">
        <source type="image/webp" srcset="/img/formula-wrong-300.webp 300w, /img/formula-wrong-600.webp 600w, /img/formula-wrong-900.webp 900w" sizes="100vw">
        <source type="image/png" srcset="/img/formula-wrong-300.png 300w, /img/formula-wrong-600.png 600w, /img/formula-wrong-900.png 900w" sizes="100vw">
        <img src="/img/formula-wrong-600.png" alt="MathML rendering in Firefox with mfenced tag" loading="lazy" decoding="async" width="600" sizes="(max-width: 600px) 100vw, 600px" srcset="/img/formula-wrong-300.png 300w, /img/formula-wrong-600.png 600w, /img/formula-wrong-900.png 900w">
    </picture>
    <figcaption>How above code is rendered in Firefox 142.0.1 (no parentheses).</figcaption>
</figure>

It turns out `mfenced` tag is <a href="https://developer.mozilla.org/en-US/docs/Web/MathML/Reference/Element/mfenced">deprecated</a>. When parens are replaced using `<mo>` tag, everything looked fine (you saw that formula rendered above if your browser supports MathML):
```xml
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
	<mrow>
		<mi>E</mi>
		<mo>≈</mo>
		<msub><mi>m</mi><mn>0</mn></msub>
		<msup><mi>c</mi><mn>2</mn></msup>
		<mo>+</mo>
		<mrow>
			<mfrac><mn>1</mn><mn>2</mn></mfrac>
			<msub><mi>m</mi><mn>0</mn></msub>
			<msup><mi>v</mi><mn>2</mn></msup>
			<mo>(</mo>
			<mrow>
				<mn>1</mn>
				<mo>+</mo>
				<mfrac>
					<mrow>
						<mn>3</mn>
						<msup><mi>v</mi><mn>2</mn></msup>
					</mrow>
					<mrow>
						<mn>4</mn>
						<msup><mi>c</mi><mn>2</mn></msup>
					</mrow>
				</mfrac>
			</mrow>
			<mo>)</mo>
		</mrow>
	</mrow>
</math>
```

### Code blocks

As you can tell from all these convoluted xml blocks above, I like code samples. I use [Shiki](https://shiki.style/) for code syntax highlighting and I love it. I like the idea of highlighting applied at build time as opposed to other runtime highlighters. This [post](https://claas.dev/posts/shiki-with-eleventy/) is what helped me to integrate Shiki to Eleventy setup.

### Hosting and domain

The previous site was hosted via [GitHub Pages](https://docs.github.com/en/pages) which was sufficient at the time, also it was important for me that the hosting is free. With the new version, I chose to move to [Netlify](https://www.netlify.com/) with their free tier. It was nice to see that Netlify supports [Brotli](https://www.brotli.org/) encoding.
```
HTTP/2 200
accept-ranges: bytes
age: 0
cache-control: public,max-age=0,must-revalidate
cache-status: "Netlify Edge"; fwd=miss
content-encoding: br
content-type: text/html; charset=UTF-8
date: Thu, 04 Sep 2025 11:30:09 GMT
etag: "ba4ba4eb10e05c9cefe80821a7fdfa54-ssl-df"
server: Netlify
strict-transport-security: max-age=31536000
vary: Accept-Encoding
x-nf-request-id: 01K4A7VG78231MNH8KX095X2Z8
X-Firefox-Spdy: h2
```
Or I should stop wondering at such things already? 🤔

Domain redirect to Netlify wasn't so smooth, surprisingly. My domain lives with GoDaddy, and a casual login there didn't work - they rejected my Belarusian phone number. So I filed a request with support and waited for ~3 days to get my 2nd factor changed to e-mail, then I could login and remap domain to Netlify's name servers. Another thing worth mentioning about GoDaddy is that they do not support `ALIAS`, `ANAME`, `flattened CNAME` records, only `A` ones.

## Remaining challenges and conclusion

There are still some remaining challenges I'd like to tackle:

- I'm yet to improve the PageSpeed Insights score, mostly by using even lighter image sources
- I want to add a 👍 system for posts, which would require implementing some server-side functionality and proxying via Netlify

Here's a comparison showing the before and after of the redesign:

<figure>
  <picture>
    <source srcset="/img/site-comparison-no-gap-300.avif 300w, /img/site-comparison-no-gap-600.avif 600w, /img/site-comparison-no-gap-900.avif 900w" type="image/avif" sizes="100vw">
    <source srcset="/img/site-comparison-no-gap-300.webp 300w, /img/site-comparison-no-gap-600.webp 600w, /img/site-comparison-no-gap-900.webp 900w" type="image/webp" sizes="100vw">
    <source srcset="/img/site-comparison-no-gap-300.png 300w, /img/site-comparison-no-gap-600.png 600w, /img/site-comparison-no-gap-900.png 900w" type="image/png" sizes="100vw">
    <img src="/img/site-comparison-no-gap-600.png" width="600" alt="Before and after comparison of the website redesign" loading="lazy" decoding="async" sizes="(max-width: 680px) 100vw, 680px" srcset="/img/site-comparison-no-gap-300.png 300w, /img/site-comparison-no-gap-600.png 600w, /img/site-comparison-no-gap-900.png 900w">
  </picture>
  <figcaption>Before and after comparison of the website redesign.</figcaption>
</figure>

Hopefully now I will be able to get a [benefits](https://eax.me/blog-story/) from having a blog - like better structured memories of the events. Thank you for your attention.
