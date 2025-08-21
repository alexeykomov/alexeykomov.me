---
title: "Fun exercise: sum of numbers through infinite currying in JS."
description: A JavaScript exercise exploring infinite currying to create a function that sums numbers through chained calls.
date: 2016-09-07
tags: ["JavaScript", "currying", "functional programming", "exercises"]
---

There's a fun question (depending on you definition of fun, of course 😆). How do you write function sum, so that the following is true?

```javascript
sum(1) == 1;//true
sum(1)(2) == 3;//true
sum(1)(4)(1) == 6;//true
/*And works on any number of curried calls, adding numbers from each call.*/
```

Comment here with your solutions. :) If you're not sure (like was I when was first asked this 🤔) or curious, read on.

Notice two important parts here: how we check equality of function result (with `==`) and how every result of sum call is callable itself. From point two it's obvious that every result of sum's call is function itself.

From ECMAScript standard we know that when operator `==` is performed on values of two different types, both are coerced to number. Right hand is already a number and left hand (which is function) will obviously be `NaN`. You can check it with explicit convertion to number:

```javascript
+function(){};//NaN 
```

So, tests like this are equivalent

```javascript
sum(1) == 1;//true
sum(1)(2) == 3;//true
sum(1)(4)(1) == 6;//true
+sum(1);//1
+sum(1)(2);//3
+sum(1)(4)(1);//6
```

And how do we override this "to NaN" behavior and return whatever value we want? By implementing our own `valueOf`. So now, at least this part is clear:

<script src="https://gist.github.com/alexeykomov/d6d6989865aa6676650f5547692a130d.js?file=sum-by-currying-blog-1.js"></script>

Okay, now it works with

```javascript
sum(1) == 1; 
```

condition at least. And how do we implement `newFunction` from above?

To chain call we would like to return `sum` itself. But if we did that

```javascript
const newFunction = sum;
```

, result of every chained call will be argument `firstArgument` returned, not sum.

So lets wrap sum with function that takes argument and calls sum with this new argument + old argument `firstArgument` from main sum function.

<script src="https://gist.github.com/alexeykomov/e6e5120858405daf6c64ee95ac11fec0.js?file=sum-by-currying-blog-2.js"></script>

Okay, let's test this implementation.

```javascript
+sum(1)
1
+sum(1)(2)
3
+sum(1)(2)(3)
6
```

Looks OK!

Those of you who eager to get a solution could stick to this one ✋. But if you want to elaborate even further, read on.

Okay, to be honest, I don't like previous solution that much. How about this one?

<script src="https://gist.github.com/alexeykomov/7ce0d67813e602e5a4d45adcba28f508.js?file=sum-by-currying-stack.js"></script>

Here, we pass the stack of all accumulated arguments down to recursive call. And in `valueOf` call, stack is transformed to a number via reduce just in time. This gives us more flexibility, imo, if we wanted to change chained sum to chained multiplication or whatever else — we just plug in different reduce function.

Okay, this time that's all for certain 😂. Cya.