---
title: Physics of Momentum Scrolling
description: Exploring the technical challenges and solutions for implementing custom scrolling behavior in web browsers, particularly addressing iOS Safari's scrolling issues.
date: 2018-06-01
tags: scrolling, iOS, Safari, web development, physics
---

Why would anyone want to re-implement scrolling in browser? The quick answer would be: in modern times — no-one. Isn't it obvious? Well, it turns out, not quite.

When developing one of my projects — Reflect calendar, I've encountered the issue in iOS Safari's scrolling— whenever you update/create scrollable element via setting innerHTML of its parent, scrollable field doesn't get its "scrollablity" immediately. Sometimes you drag the whole screen instead of dragging only scrollable area's content.

This problem also manifests itself when you're dragging the whole screen by some element outside of scrollable area, and then trying to scroll inside that area. You should wait until the whole screen "settles down" and approximately one more second to do that. Looks like this problem has a name — "overscroll".

![iOS Safari scrolling issue demonstration](https://miro.medium.com/v2/resize:fit:540/format:webp/1*cQqmLnDFVyRN0JwbKpQQYQ.gif)

Now, is it really worth a concern doing something about it? After all, native is native and we won't get any better option, right?

Here's where we fall to this "uncanny valley" of UI. Say, you want your web-application to feel "native" as much as it reasonable in mobile web browser. But, with things like overscroll happening, a user will notice that it's not nearly as native as iOS gives you through SDK.

Sure, if you wanted native, you'd go with React Native and all, but why not push it to the limits when it's possible? And in modern web — it's totally possible. Moreover — it has been done! By Ryan Fioravanti, for Gmail web version for iOS (which means two separate versions for iPhone/iPod and iPad). Here's the article by Ryan. I suggest you read it — it's really good. It was done for another reason — Safari didn't have position:fixed back then, and overflow-scrolling: touch had yet to come.

Anyway, let's dive into the article and see whether it's possible to implement momentum scrolling in JS as close to the native as possible.

We're discovering immediately that Ryan's solution is based on transitions — the simplest possible animations. And another good part that these particular transitions are hardware accelerated — the ones that animate opacity, translation, rotation and scaling. So, basically, making scrolling through transitions comes down to prepare right end state, commit it to the element which will be scrolled and then give it proper transition flavor, so that element will move its way gracefully and up to a user's expectations.

First, let's show what momentum scrolling will look in the end.

![Momentum scrolling implementation result](https://miro.medium.com/v2/resize:fit:540/format:webp/1*PG1jOvS3KnQhpS_bxDGt2A.gif)

Ryan's article describes basis DOM setup, drag'n'drop part via touch events and translate3d transform property. This should be fairly intuitive. Now, the heart of logic is this method — doing momentum whenever user releases touch with some velocity prior to that.

```javascript
rflect.ui.MomentumScroller.prototype.doMomentum = function() {
  // Calculate the movement properties. Implement getEndVelocity using the
  // start and end position / time.
  var velocity = this.getEndVelocity();
  if (velocity != 0) {
    var acceleration = this.getAcceleration(velocity);
    var displacement = - (velocity * velocity) / (2 * acceleration);
    var time = - velocity / acceleration;

    var newY = this.contentOffsetY + displacement;

    if (this.positionIsOutOfBounds(newY)) {

      this.setUpTransitionStage1();

    } else {

      // Set up the transition and execute the transform. Once you implement this
      // you will need to figure out an appropriate time to clear the transition
      // so that it doesn't apply to subsequent scrolling.
      let transition =
          rflect.browser.css.getSelectorCasedProperty('transform') + ' ' +
          time + 'ms cubic-bezier(0.33, 0.66, 0.66, 1)';

      rflect.browser.css.setTransition(this.element, transition);
      rflect.browser.css.setTransition(this.getScrollBarContainer(), transition);
      this.contentOffsetY = newY;
      rflect.browser.css.setTransform(this.element,
          `translate3d(0, ${newY}px, 0)`);
      rflect.browser.css.setTransform(this.getScrollBarContainer(),
          `translate3d(0, ${-(newY / this.getSizeRatio() -
          this.getScrollBarLineHeight() / 2)}px, 0)`);
    }

    this.isDecelerating_ = true;
  } else {
    this.showScrollBarDelayed(false);
  }
}
```

As you can see, we're doing here: getting end velocity of user's touch (line #2), calculating displacement(line #7) and time (line #8). The we're updating element with new position (line #28) via translation. And, finally, in order for movement to look natural, we're applying proper transition (line #21) to scrollable element. This transition function is cubic-bezier(0.33, 0.66, 0.66, 1) and is kindly given by Ryan.

Let's take a moment and reconsider this more carefully.

First, some theory and formulae for accelerated movement:

<figure>
  <img src="https://miro.medium.com/v2/resize:fit:1200/format:webp/1*3ZYRa-ZdSHX1zJpBqOiLbg.png" alt="Velocity formula" style="width:100%">
  <figcaption>Fig 1. Velocity</figcaption>
</figure>

<figure>
  <img src="https://miro.medium.com/v2/resize:fit:1200/format:webp/1*3lo-InaOjkgAwatiq-mONw.png" alt="Displacement formula" style="width:100%">
  <figcaption>Fig 2. Displacement</figcaption>
</figure>

<figure>
  <img src="https://miro.medium.com/v2/resize:fit:1200/format:webp/1*sPUX1kKNiaSQz9GGcE2wSQ.png" alt="Time formula" style="width:100%">
  <figcaption>Fig 3. Time</figcaption>
</figure>

<figure>
  <img src="https://miro.medium.com/v2/resize:fit:1200/format:webp/1*1mb37V5aKbp7-OtcaNmrXQ.png" alt="Displacement formula" style="width:100%">
  <figcaption>Fig4. Displacement</figcaption>
</figure>

Last formula (Fig. 4) is derived from formula on Fig. 2 by moving x minus x0 to the left and replacing time by expression in Fig. 3. So we're using these formulae to get displacement and time in the doMomentum function, nothing particularly special.

Now that we know how far and how long our movement will take, it's time to apply proper transition to this movement. Fortunately, Ryan gives us one — cubic bezier for slow deceleration ending in full stop (velocity is zero).

So now we have basic implementation of how content will behave should it decelerate to zero velocity.

Also, quite simple is the returning content from out of bounds position to frame. Here's how it looks.

![Returning content from out of bounds position](https://miro.medium.com/v2/resize:fit:540/format:webp/1*eYS2F9_GMHWH7Yao4kr4Pg.gif)

Implementation of this method is here.

```javascript
rflect.ui.MomentumScroller.prototype.snapToBounds = function() {
  const transition = rflect.browser.css.getSelectorCasedProperty('transform') +
    ' ' + 500 + 'ms ease-out';
  this.setTransitionAll(transition);

  // Different out of bounds cases:
  // 1. If content is lower than frame upper border
  if (this.contentOffsetY > 0) {
    this.contentOffsetY = 0;
    rflect.browser.css.setTransform(this.getScrollBarContainer(),
        `translate3d(0, ${(this.getScrollBarLineHeight() / 2)}px, 0)`);
  }
  else {
  // 2. If content is higher that frame lower border.
    this.contentOffsetY = this.getLowestContentPosition();
    rflect.browser.css.setTransform(this.getScrollBarContainer(),
        `translate3d(0, ${this.frameElementSize.height -
        this.getScrollBarLineHeight() / 2}px, 0)`);
  }

  rflect.browser.css.setTransform(this.element,
      `translate3d(0, ${this.contentOffsetY}px, 0)`);
  rflect.browser.css.setTransform(this.getScrollBarLine(),
      `scaleY(${this.getScrollBarLineHeight()})`);

  this.isDecelerating_ = true;
}
```

As you can see, it it simply detection of whether we're out of bounds and then applying transition to return content into frame. Transition function is simple ease-out and time is constant 500ms.

Now the most complex case is left — when deceleration takes content out of bounds. In this case, we have three stages with separate transition each:

1. Transition that takes content exactly to bounds.
2. Transition that takes content from the edge to zero velocity.
3. Transition that returns content to bounds (snapToBounds).

To better illustrate this, here's visualization.

![Three-stage transition visualization](https://miro.medium.com/v2/resize:fit:540/format:webp/1*MrsLEa86DbUcE7jYAOc_pw.gif)

Actually, part 2 is simple deceleration to zero velocity, which we've already implemented.

The interesting part is 1 — we need to translate content with non-zero velocity left in the end. This requires us different bezier function, but which one? Ryan writes obscurely that this case is outside of article's scope.

This is apex point of my research in this problem and it brought me incredible satisfaction to finally find the answer! The feeling which, I believe, each engineer is striving for.

Turns out, the look of function will be different for each end velocity. Let us illustrate it by this pictures.

<figure>
  <div style="display: flex; flex-wrap: wrap; gap: 10px; justify-content: center; margin: 1rem 0;">
    <img src="https://miro.medium.com/v2/resize:fit:600/format:webp/1*veDWBM_Qd1iW-diPjoH7wg.png" alt="Bezier function with zero end velocity" style="flex: 1; min-width: 200px; max-width: 600px;">
    <img src="https://miro.medium.com/v2/resize:fit:600/format:webp/1*deYf-34nZ5FlqVEvqSuxNw.png" alt="Bezier function with non-zero end velocity" style="flex: 1; min-width: 200px; max-width: 600px;">
    <img src="https://miro.medium.com/v2/resize:fit:600/format:webp/1*hWo1JLT-TAdMSLjZDCz2iA.png" alt="Bezier function with same start and end velocity" style="flex: 1; min-width: 200px; max-width: 600px;">
  </div>
  <figcaption>Different bezier deceleration functions.</figcaption>
</figure>

1. On first picture, there's an edge case — deceleration takes content to zero end velocity.
2. On second, end velocity is bigger than zero.
3. On third, end velocity is the same as start velocity.

So you see relation here — the less end velocity will differ from start velocity, the more flat cubic bezier function will be, up to the limit of simple line (cubic-bezier(.33,.33,.66,.66) or linear). The maximal difference between start and end velocity is when end velocity is zero. In this case function will be cubic-bezier(0.33, 0.66, 0.66, 1). And in any case in between, the function will look like cubic-bezier(0.33, 0.66-x, 0.66, 1-x) where x = abs(endVelocity/startVelocity).

So we're finally here! The demo of working implementation could be seen http://alexeykomov.me/momentum-scroller-demo.

Thanks you for attention.
