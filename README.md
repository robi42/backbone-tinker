# Backbone Tinker

This is a little playground for cutting-edge single-page JS app dev.

## Dependencies

* Java (for Google Closure compiler usage)
* [Node.js](https://github.com/joyent/node) (0.4.4)
  * [npm](https://github.com/isaacs/npm)
  * [CoffeeScript](https://github.com/jashkenas/coffee-script)
  * [Stylus](https://github.com/LearnBoost/stylus)
  * [Eco](https://github.com/sstephenson/eco)
  * [Stitch](https://github.com/sstephenson/stitch)
  * [Express](https://github.com/visionmedia/express)
  * [Nodeunit](https://github.com/caolan/nodeunit)
  * [Tobi](https://github.com/LearnBoost/tobi)
  * [Backbone](https://github.com/documentcloud/backbone)
  * [Docco](https://github.com/jashkenas/docco) (+ [Pygments](http://pygments.org/download/))

Mentioned packages are installable via `npm`.

Usage example:

    $ npm install coffee-script

## Howto

Launch dev server:

    $ cake run:express

Now, point your browser to `localhost:3333` and enjoy hacking.

FYI: source code resides in `src`, (on-the-fly) compiled code in `public`.

Additionally, deployable code can be found in `build` and (re)built via:

    $ cake build

BTW, Google Closure compiler is used for JS minification and optimization.

Test suite can be run as follows:

    $ cake test

Documentation can be (re)generated in `public/docs` via:

    $ cake gen:docco
