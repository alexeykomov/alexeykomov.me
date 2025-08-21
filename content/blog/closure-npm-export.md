---
title: How to export closure-compiled code in npm module
description: A guide to packaging and exporting Closure Compiler optimized JavaScript code as npm modules for distribution.
date: 2016-04-03
tags: ["Closure Compiler", "npm", "JavaScript", "modules", "packaging"]
---

Recently, I've discovered that it's somewhat non-trivial to add block of closure-compiled code to npm as a module.

In order for it to be discoverable by Node.js module system, I did the following:

1. Export non-obfuscated name of public API as a global variable (or module-scoped variable in case of Node.js).
2. Wrap compiled code with some of the UMD patterns.

Let's explain it by example. Say, I have some class called `rflect.ui.MomentumScroller` and I want it to be exported by name `MomentumScroller`.

```javascript
/* Closure-compiled code which defines rflect.ui.MomentumScroller is here. */
goog.exportSymbol('MomentumScroller', rflect.ui.MomentumScroller);
```

By this point, I could've already used it in browser by global name `MomentumScroller`. But, in order for it to be used as npm module, let's wrap it with:

```javascript
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define([], factory);
    } else if (typeof module === 'object' && module.exports) {
        module.exports = factory();
    } else {
        root.MomentumScroller = factory();
  }
}(this, function () {
  %output%
  return MomentumScroller;
}));
```

…where `%output%` is placeholder for your closure-compiled code. Actually, it's one step from final compilation command:

```bash
python 
src/closure/closure/bin/build/closurebuilder.py 
-n rflect.ui.MomentumScroller 
--root=src/closure 
--root=src/reflect 
--root=src/momentum-scroller 
-o compiled 
--output_file=build/momentum-scroller.js --compiler_jar=bin/compiler.jar 
--compiler_flags=\"--charset=utf-8\" 
--compiler_flags=\"--compilation_level=ADVANCED_OPTIMIZATIONS\" --compiler_flags=\"--summary_detail_level=3\" 
--compiler_flags=\"--warning_level=VERBOSE\" 
--compiler_flags=\"--js=src/closure/closure/goog/deps.js\" --compiler_flags=\"--debug=false\" 
--compiler_flags=\"--source_map_format=V3\" 
--compiler_flags=\"--closure_entry_point=rflect.ui.MomentumScroller\" --compiler_flags=\"--language_in=ECMASCRIPT6\" 
--compiler_flags=\"--language_out=ECMASCRIPT5\" --compiler_flags=\"--externs=src/externs.js\" 
--compiler_flags=\"--define='goog.DEBUG=false'\" --compiler_flags=\"--js=src/momentum-scroller/api.js\" --compiler_flags=\"--process_common_js_modules\" --compiler_flags=\"--output_wrapper=;(function (root, factory) {\n    if (typeof define === 'function' && define.amd) {\n        define([], factory);\n    } else if (typeof module === 'object' && module.exports) {\n        module.exports = factory();\n    } else {\n        root.MomentumScroller = factory();\n  }\n}(this, function () {\n  %output%\n  return MomentumScroller;\n}));\"
```

Important part of this scary command is in *--output_wrapper*, we've just used `\n`s instead of newlines.

So, in order to export closure-compiled code in npm module, we could use Closure Compiler's `--output_wrapper` option and exported public API variable.

If you've found more effective ways to export closure-compiled code in Node.js, please let me know.

Cheers!