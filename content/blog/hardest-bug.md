---
title: "Hardest bug to find. So far…"
description: A challenging debugging experience from October 2013
date: 2013-10-10
tags: ["debugging", "programming", "Closure Compiler", "Closure Library"]
---

The story I'm about to tell happened while I've been developing [Reflect calendar](https://reflectcal.com), which was undoubtedly a large javascript application. The story of developing and being enlightened with ideas is most surely a story of itself, so maybe it will be told some time in the future. For now, it'll be enough to say that choice of [closure library](https://code.google.com/p/closure-library/) and [closure compiler](https://developers.google.com/closure/compiler/) was only logical for an app of such scale.

Most development time was spent working with code in uncompiled form, though I did some compilation runs just to see what size compiled code would have. It was actually fun to see how code grew to 50k, then to 70k and then to dreadful — for that point — 100k. Then I added a gzip ant task on top of the compile task to reassure myself that what mattered was the gzipped size, not the ungzipped size.

So it was finally time to compile whole application and to see if compilation broke any functionality.

And it did.

```plain
Uncaught TypeError: boolean is not a function
```

What was considered a boolean, mapped through source map in Chrome to perfectly looking function:

```plain
this.mainPaneBuilder_ = new rflect.cal.ui.MainPaneBuilder(this.viewManager_, …)
```

That said, the compiler at that stage was generating 109 warnings. Most were about private properties being overridden and class methods being incorrectly overridden. So at first, I tried to remove every and each warning, just to be sure that compiler does not complain. It was one strange thing though: —debug (dash-dash-debug) option was producing error-less compiled code.

So I removed every warning except one, coming from loader class:

```plain
WARNING — Bad type annotation. Unknown type rflect.cal.Loader
* @this {rflect.cal.Loader}
^
```

You may notice @this directive here. That's because earlier compiler was complaining that my non-constructor, plain object has methods that reference "this" in them. And I didn't want to get rid of "this" inside those methods. You see, Loader is just a plain object here.

```javascript
goog.provide('rflect.cal.Loader');
goog.require('goog.events');
goog.require('rflect.Debug');
goog.require('rflect.cal.Main');

/**
 * Binds creation of cal instance to load events.
 * @this {rflect.cal.Loader}
 */
rflect.cal.Loader.main = function() {
  goog.events.listenOnce(window, 'load', function(aEvent) {
    // Load event will fire later than dom ready.
    if (!this.documentLoaded_)
      this.calInstance_ = new rflect.cal.Main();
  }, false, this);

  goog.events.listenOnce(window, 'DOMContentLoaded', function(aEvent) {
    this.documentLoaded_ = true;
    this.calInstance_ = new rflect.cal.Main();
  }, false, this);

  goog.events.listenOnce(window, 'unload', function(aEvent) {
    if (this.calInstance_)
      this.calInstance_.dispose();
  }, false, this);
};
```

But the warning was about an unknown type, wasn't it? I recalled that previous such cases were solved by adding *deps.js* file to compilation, as suggested [here](http://code.google.com/p/closure-library/wiki/FrequentlyAskedQuestions#When_I_compile_with_type-checking_on,_I_get_warnings_about_%22). But for this particular case it didn't help, so I forgot about it for a while.

So, I was at the point when the compiler emitted one warning ignored by me and erroneous compiled code. Hm…

The next thing I remembered was that with the —debug directive code was working. So in compiler source code I opened method which added options to compilation.

```java
public void setDebugOptionsForCompilationLevel(CompilerOptions options) {
  options.anonymousFunctionNaming = AnonymousFunctionNamingPolicy.UNMAPPED;
  options.generatePseudoNames = true;
  options.removeClosureAsserts = false;
  // Don't shadow variables as it is too confusing.
  options.shadowVariables = false;
}
```

So there are 4 possibilities which could be responsible for broken code. By rebuilding compiler with different options on/off, I tracked one that was responsible: the essential one — variable renaming (options.generatePseudoNames being false).

Then I tried to search variable name ("Rk" most of the time, but there were different namings) without source map, in compiled code. And… voila, I spotted such a piece (by luck, just because it was at the very end of compiled file):

```javascript
function Vl() {
  Ub(window, "load", function() {
    this.Rk || (this.Vg = new Tl)
  }, !1, this);

  Ub(window, "DOMContentLoaded", function() {
    this.Rk = !0;
    this.Vg = new Tl
  }, !1, this);

  Ub(window, "unload", function() {
    this.Vg && this.Vg.K()
  }, !1, this)
}
```

Do you see any familiarity here? :) It was compiled code for loader, which, here, used "this" to assign property "Rk". Now what we see:

1. Initially, in uncompiled file "this" inside plain object was ok, because object existed.
2. After compilation, object was dissolved, and its method became global function, which assigned "Rk" to global space, which, by turn, clobbered some another "Rk" property (in my case, constructor function) which became boolean, true one!
3. Compilation with —debug statement worked because names won't collide, being derived from original ones, like "`$rflect$cal$Loader$main$`".
4. When I redesigned the loader as a class with constructor and prototype, not only it removed error, but also strange warning of unknown type.

So morals here: do not use "this" inside of plain objects, but only in constructors and prototypes. I knew this and it was told here. But what I didn't know is that `@this` directive won't help to preserve object to which "this" is pointing! It'll just silence compiler. So my version of this rule is — do not ever use "this" outside of constructors and prototype methods AND do not attempt to silence compiler by @this directive.

Hope you enjoyed the reading. Thanks for your attention. See ya.
