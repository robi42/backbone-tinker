# Backbone Tinker

This is a little playground for cutting-edge single-page JS app dev.

## Dependencies

* Java (5+)
* [Sbt](http://code.google.com/p/simple-build-tool/wiki/Setup) (0.7.5)
* [MongoDB](http://www.mongodb.org/display/DOCS/Quickstart)
* [Node.js](https://github.com/joyent/node) (0.4+)
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

Mentioned Node packages are installable via `npm`.

Usage example:

    $ npm install coffee-script

## Howto

First of all, build backend:

    $ cd backend
    $ sbt
    > update
    > package

Then, start MongoDB server, e.g.:

    $ mongod

And backend API server:

    $ cd backend
    $ ./run-blueeyes.sh

Now, launch frontend dev server:

    $ cd frontend
    $ cake run:express

Finally, point your browser to `localhost:3333` and enjoy hacking.

FYI: frontend source code resides in `src`, (on-the-fly) compiled code in `public`.

Additionally, deployable frontend code can be found in `build` and (re)built via:

    $ cake build

BTW, Google Closure compiler is used for JS minification and optimization.

Frontend test suite can be run as follows:

    $ cake test

Frontend documentation can be (re)generated in `public/docs` via:

    $ cake gen:docco
