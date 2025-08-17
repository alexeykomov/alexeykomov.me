---
title: Physics of Momentum Scrolling
description: Exploring the technical challenges and solutions for implementing custom scrolling behavior in web browsers, particularly addressing iOS Safari's scrolling issues.
date: 2016-06-02
tags: scrolling, iOS, Safari, web development, physics
---

Why would anyone want to re-implement scrolling in browser? The quick answer would be: in modern times — no-one. Isn't it obvious? Well, it turns out, not quite.

When developing one of my projects — [Reflect calendar](https://reflectcal.com), I've encountered the issue in iOS Safari's scrolling— whenever you update/create scrollable element via setting innerHTML of its parent, scrollable field doesn't get its "scrollablity" immediately. Sometimes you drag the whole screen instead of dragging only scrollable area's content.

This problem also manifests itself when you're dragging the whole screen by some element outside of scrollable area, and then trying to scroll inside that area. You should wait until the whole screen "settles down" and approximately one more second to do that. Looks like this problem has a name — "overscroll".

<video autoplay loop muted playsinline style="width:100%; max-width:270px;">
  <source src="/blog/momentum-scrolling/ios-safari-scrolling.webm" type="video/webm">
  <source src="/blog/momentum-scrolling/ios-safari-scrolling.mp4" type="video/mp4">
  <picture style="width:100%; max-width:270px;">
    <source srcset="/blog/momentum-scrolling/0BeGvm-juB-270.webp" type="image/webp">
    <img src="/blog/momentum-scrolling/0BeGvm-juB-270.gif" alt="iOS Safari scrolling issue demonstration" style="width:100%; max-width:270px;">
  </picture>
</video>

Now, is it really worth a concern doing something about it? After all, native is native and we won't get any better option, right?

Here's where we fall to this ["uncanny valley" of UI](http://blog.codinghorror.com/avoiding-the-uncanny-valley-of-user-interface/). Say, you want your web-application to feel "native" as much as it reasonable in mobile web browser. But, with things like overscroll happening, a user will notice that it's not nearly as native as iOS gives you through SDK.

Sure, if you wanted native, you'd go with React Native and all, but why not push it to the limits when it's possible? And in modern web — it's totally possible. Moreover — it has been done! By Ryan Fioravanti, for Gmail web version for iOS (which means two separate versions for iPhone/iPod and iPad). Here's the [article by Ryan](https://web.archive.org/web/20141001100814/https://developers.google.com/mobile/articles/webapp_fixed_ui#bg). I suggest you read it — it's really good. It was done for another reason — Safari didn't have position:fixed back then, and overflow-scrolling: touch had yet to come.

Anyway, let's dive into the article and see whether it's possible to implement momentum scrolling in JS as close to the native as possible.

We're discovering immediately that Ryan's solution is based on transitions — the simplest possible animations. And another good part that these particular transitions are hardware accelerated — the ones that animate opacity, translation, rotation and scaling. So, basically, making scrolling through transitions comes down to prepare right end state, commit it to the element which will be scrolled and then give it proper transition flavor, so that element will move its way gracefully and up to a user's expectations.

First, let's show what momentum scrolling will look in the end.

<video autoplay loop muted playsinline style="width:100%; max-width:270px;">
  <source src="/blog/momentum-scrolling/momentum-scrolling-result.webm" type="video/webm">
  <source src="/blog/momentum-scrolling/momentum-scrolling-result.mp4" type="video/mp4">
  <picture style="width:100%; max-width:270px;">
    <source srcset="/blog/momentum-scrolling/bNFA7l4R84-270.webp" type="image/webp">
    <img src="/blog/momentum-scrolling/bNFA7l4R84-270.gif" alt="Momentum scrolling implementation result" style="width:100%; max-width:270px;">
  </picture>
</video>

Ryan's article describes basis DOM setup, drag'n'drop part via touch events and translate3d transform property. This should be fairly intuitive. Now, the heart of logic is this method — doing momentum whenever user releases touch with some velocity prior to that.

<script src="https://gist.github.com/alexeykomov/d27ebc94b1f302d03baf5ba7957d199b.js?file=do-momentum.js"></script>

As you can see, we're doing here: getting end velocity of user's touch ([line #2](https://gist.github.com/alexeykomov/d27ebc94b1f302d03baf5ba7957d199b#file-do-momentum-js-L2)), calculating displacement([line #7](https://gist.github.com/alexeykomov/d27ebc94b1f302d03baf5ba7957d199b#file-do-momentum-js-L7)) and time ([line #8](https://gist.github.com/alexeykomov/d27ebc94b1f302d03baf5ba7957d199b#file-do-momentum-js-L8)). The we're updating element with new position ([line #28](https://gist.github.com/alexeykomov/d27ebc94b1f302d03baf5ba7957d199b#file-do-momentum-js-L28)) via translation. And, finally, in order for movement to look natural, we're applying proper transition ([line #21](https://gist.github.com/alexeykomov/d27ebc94b1f302d03baf5ba7957d199b#file-do-momentum-js-L21)) to scrollable element. This transition function is cubic-bezier(0.33, 0.66, 0.66, 1) and is kindly given by Ryan.

Let's take a moment and reconsider this more carefully.

First, some theory and formulae for accelerated movement:

<figure id="fig1">
  <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <mi>v</mi>
      <mo>=</mo>
      <msub>
          <mi>v</mi>
          <mn>0</mn>
      </msub>
      <mo>+</mo>
      <mi>a</mi>
      <mi>t</mi>
  </math>
  <noscript>
    <img src="https://miro.medium.com/v2/resize:fit:1200/format:webp/1*3ZYRa-ZdSHX1zJpBqOiLbg.png" alt="Velocity formula" style="width:100%">
  </noscript>
  <figcaption>Fig 1. Velocity</figcaption>
</figure>

<figure id="fig2">
  <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <mi>x</mi>
      <mo>=</mo>
      <msub>
          <mi>x</mi>
          <mn>0</mn>
      </msub>
      <mo>+</mo>
      <msub>
          <mi>v</mi>
          <mn>0</mn>
      </msub>
      <mi>t</mi>
      <mo>+</mo>
      <mfrac>
          <mrow>
              <mi>a</mi>
              <msup>
                  <mi>t</mi>
                  <mn>2</mn>
              </msup>
          </mrow>
          <mn>2</mn>
      </mfrac>
  </math>
  <noscript>
    <img src="https://miro.medium.com/v2/resize:fit:1200/format:webp/1*3lo-InaOjkgAwatiq-mONw.png" alt="Displacement formula" style="width:100%">
  </noscript>
  <figcaption>Fig 2. Displacement</figcaption>
</figure>

<figure id="fig3">
  <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <mi>t</mi>
      <mo>=</mo>
      <mfrac>
          <mrow>
              <mi>v</mi>
              <mo>-</mo>
              <msub>
                  <mi>v</mi>
                  <mn>0</mn>
              </msub>
          </mrow>
          <mi>a</mi>
      </mfrac>
  </math>
  <noscript>
    <img src="https://miro.medium.com/v2/resize:fit:1200/format:webp/1*sPUX1kKNiaSQz9GGcE2wSQ.png" alt="Time formula" style="width:100%">
  </noscript>
  <figcaption>Fig 3. Time</figcaption>
</figure>

<figure id="fig4">
  <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
      <mi mathvariant="normal">Δ</mi>
      <mi>x</mi>
      <mo>=</mo>
      <mfrac>
          <mrow>
              <msup>
                  <mi>v</mi>
                  <mn>2</mn>
              </msup>
              <mo>-</mo>
              <msubsup>
                  <mi>v</mi>
                  <mn>0</mn>
              </msubsup>
          </mrow>
          <mrow>
              <mn>2</mn>
              <mi>a</mi>
          </mrow>
      </mfrac>
  </math>
  <noscript>
    <img src="https://miro.medium.com/v2/resize:fit:1200/format:webp/1*1mb37V5aKbp7-OtcaNmrXQ.png" alt="Displacement formula" style="width:100%">
  </noscript>
  <figcaption>Fig4. Displacement</figcaption>
</figure>

Last formula (<a href="#fig4">Fig. 4</a>) is derived from formula on <a href="#fig2">Fig. 2</a> by moving x minus x0 to the left and replacing time by expression in <a href="#fig3">Fig. 3</a>. So we're using these formulae to get displacement and time in the doMomentum function, nothing particularly special.

Now that we know how far and how long our movement will take, it's time to apply proper transition to this movement. Fortunately, Ryan gives us one — cubic bezier for slow deceleration ending in full stop (velocity is zero).

So now we have basic implementation of how content will behave should it decelerate to zero velocity.

Also, quite simple is the returning content from out of bounds position to frame. Here's how it looks.

<video autoplay loop muted playsinline style="width:100%; max-width:270px;">
  <source src="/blog/momentum-scrolling/returning-content.webm" type="video/webm">
  <source src="/blog/momentum-scrolling/returning-content.mp4" type="video/mp4">
  <picture style="width:100%; max-width:270px;">
    <source srcset="/blog/momentum-scrolling/ncTGSXtJmr-270.webp" type="image/webp">
    <img src="/blog/momentum-scrolling/ncTGSXtJmr-270.gif" alt="Returning content from out of bounds position" style="width:100%; max-width:270px;">
  </picture>
</video>

Implementation of this method is here.

<script src="https://gist.github.com/alexeykomov/5181836ee013465bd85f825dac9a7a5e.js?file=snap-to-bounds.js"></script>

As you can see, it it simply detection of whether we're out of bounds and then applying transition to return content into frame. Transition function is simple ease-out and time is constant 500ms.

Now the most complex case is left — when deceleration takes content out of bounds. In this case, we have three stages with separate transition each:

1. Transition that takes content exactly to bounds.
2. Transition that takes content from the edge to zero velocity.
3. Transition that returns content to bounds (snapToBounds).

To better illustrate this, here's visualization.

<video autoplay loop muted playsinline style="width:100%; max-width:270px;">
  <source src="/blog/momentum-scrolling/three-stage-transition.webm" type="video/webm">
  <source src="/blog/momentum-scrolling/three-stage-transition.mp4" type="video/mp4">
  <picture style="width:100%; max-width:270px;">
    <source srcset="/blog/momentum-scrolling/t8OoUDI5tr-270.webp" type="image/webp">
    <img src="/blog/momentum-scrolling/t8OoUDI5tr-270.gif" alt="Three-stage transition visualization" style="width:100%; max-width:270px;">
  </picture>
</video>

Actually, part 2 is simple deceleration to zero velocity, which we've already implemented.

The interesting part is 1 — we need to translate content with non-zero velocity left in the end. This requires us different bezier function, but which one? Ryan writes obscurely that this case is outside of article's scope.

This is apex point of my research in this problem and it brought me incredible satisfaction to finally find the answer! The feeling which, I believe, each engineer is striving for.

Turns out, the look of function will be different for each end velocity. Let us illustrate it by this pictures.

<figure>
  <div style="display: flex; flex-wrap: wrap; gap: 10px; justify-content: center; margin: 1rem 0;">
    <picture style="flex: 1; min-width: 200px; max-width: 600px;">
      <source srcset="/blog/momentum-scrolling/NYKY-_ffbA-300.webp" type="image/webp">
      <img src="/blog/momentum-scrolling/NYKY-_ffbA-300.jpg" alt="Bezier function with zero end velocity" loading="lazy" decoding="async" width="300" height="600">
    </picture>
    <picture style="flex: 1; min-width: 200px; max-width: 600px;">
      <source srcset="/blog/momentum-scrolling/C4a8Qig9ne-300.webp" type="image/webp">
      <img src="/blog/momentum-scrolling/C4a8Qig9ne-300.jpg" alt="Bezier function with non-zero end velocity" loading="lazy" decoding="async" width="300" height="600">
    </picture>
    <picture style="flex: 1; min-width: 200px; max-width: 600px;">
      <source srcset="/blog/momentum-scrolling/bs22Kv3DAk-300.webp" type="image/webp">
      <img src="/blog/momentum-scrolling/bs22Kv3DAk-300.jpg" alt="Bezier function with same start and end velocity" loading="lazy" decoding="async" width="300" height="600">
    </picture>
  </div>
  <figcaption>Different bezier deceleration functions.</figcaption>
</figure>

1. On first picture, there's an edge case — deceleration takes content to zero end velocity.
2. On second, end velocity is bigger than zero.
3. On third, end velocity is the same as start velocity.

So you see relation here — the less end velocity will differ from start velocity, the more flat cubic bezier function will be, up to the limit of simple line (cubic-bezier(.33,.33,.66,.66) or linear). The maximal difference between start and end velocity is when end velocity is zero. In this case function will be cubic-bezier(0.33, 0.66, 0.66, 1). And in any case in between, the function will look like cubic-bezier(0.33, 0.66-x, 0.66, 1-x) where x = abs(endVelocity/startVelocity).

So we're finally here! The demo of working implementation could be seen [http://alexeykomov.me/momentum-scroller-demo](http://alexeykomov.me/momentum-scroller-demo).

Thanks you for attention.
