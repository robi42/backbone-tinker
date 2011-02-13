# Backbone Tinker

This is a little playground for cutting-edge single-page JS app dev.

## Dependencies

* [RingoJS](https://github.com/ringo/ringojs)
  * [Stick](https://github.com/hns/stick)
  * [Ringo Modulr](https://github.com/hns/ringo-modulr)

* [Node.js](https://github.com/ry/node)
  * [npm](https://github.com/isaacs/npm)
  * [CoffeeScript](https://github.com/jashkenas/coffee-script)
  * [Stylus](https://github.com/LearnBoost/stylus)
  * [Eco](https://github.com/sstephenson/eco)
  * [Fusion](https://github.com/brunchwithcoffee/fusion)
  * [Docco](https://github.com/jashkenas/docco) (+ [Pygments](http://pygments.org/download/))

Mentioned packages are installable via `ringo-admin` and `npm` respectively.

For dev, first start compilation watchers in separate shell sessions, e.g.:

     $ ./bin/coffee-watch

Then, launch dev server:

    $ ringo server/main.js

Now, point your browser to `localhost:8080` and enjoy hacking.
