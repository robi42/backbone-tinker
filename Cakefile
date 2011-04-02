stitch  = require 'stitch'
express = require 'express'
fs      = require 'fs'
{spawn} = require 'child_process'


option '-p', '--port [NUM]', 'Port to run Express on.'
option '-l', '--location [URL]', 'Location to deploy to.'


defaultLocation = 'jdoe@example.com:backbone-tinker'
srcPath = "#{__dirname}/src/main"
publicPath = "#{__dirname}/public"
buildPath = "#{__dirname}/build"
stitchPaths = [
  "#{srcPath}/coffeescript", "#{srcPath}/eco"
]
isBuildTested = false


log = (data) ->
  console.log data.toString()
  return


testAndCleanUp = (data) ->
  log(data)

  invoke 'test' if not isBuildTested
  isBuildTested = true

  path = "#{buildPath}/app.js"

  try fs.unlink(path) catch err # Swallow.
  return


renameCss = (data) ->
  log(data)

  path1 = "#{buildPath}/screen.css"
  path2 = "#{buildPath}/screen.min.css"

  try fs.rename(path1, path2) catch err # Swallow.
  return


process = (proc, func) ->
  proc.stderr.on 'data', func
  proc.stdout.on 'data', func
  return


spawnClosure = ->
  closure = spawn('java', [
    '-jar', "#{__dirname}/bin/compiler.jar",
    '--js', "#{publicPath}/js/json2.js",
    '--js', "#{publicPath}/js/jquery-1.5.2.js",
    '--js', "#{publicPath}/js/underscore-1.1.5.js",
    '--js', "#{publicPath}/js/backbone-0.3.3.js",
    '--js', "#{publicPath}/js/backbone-localstorage.js",
    '--js', "#{buildPath}/app.js",
    '--js_output_file', "#{buildPath}/app.min.js"
  ])

  process closure, testAndCleanUp
  return


copyDirToBuild = (path) ->
  fs.readdirSync(path)
    .map((file) -> "#{path}/#{file}")
    .forEach (file) ->
      fs.writeFile file.replace(publicPath, buildPath),
        fs.readFileSync file
      return
  return


task 'build', 'Build project.', ->
  invoke 'gen:docco'

  package = stitch.createPackage(paths: stitchPaths)

  package.compile (err, source) ->
    fs.writeFile "#{buildPath}/app.js", source
    console.log 'Compiled `app.js`.'

    spawnClosure()
    return

  stylus = spawn('stylus', [
    '--out', "#{buildPath}", '--compress',
    "#{srcPath}/stylus/screen.styl"
  ])

  process stylus, renameCss

  assetTags = '''
    <link rel="stylesheet" media="all" href="screen.min.css" />
        <script src="app.min.js"></script>\n  '''

  fs.writeFile "#{buildPath}/index.html",
    fs.readFileSync("#{publicPath}/index.html").toString()
      .replace /<link.+\n\s*(<script.+\n\s*)+/, assetTags

  fs.writeFile "#{buildPath}/cache.manifest",
    fs.readFileSync("#{publicPath}/cache.manifest")

  copyDirToBuild "#{publicPath}/img"
  copyDirToBuild "#{publicPath}/docs"
  return


task 'test', 'Run test suite.', ->
  invoke 'run:express'

  {reporters} = require 'nodeunit'
  reporters.default.run ['src/test']
  return


task 'deploy', 'Deploy project.', (options) ->
  invoke 'build'

  location = options.location or defaultLocation
  scp = spawn('scp', ['-r', 'build', location])

  process scp, log
  return


task 'gen:docco', 'Generate Docco docs.', ->
  path = "#{srcPath}/coffeescript"
  files = fs.readdirSync(path)
  	.map (file) -> "#{path}/#{file}"
  docco = spawn('docco', files, cwd: publicPath)

  process docco, log
  return


task 'watch:styl', 'Watch *.styl to compile.', ->
  stylus = spawn('stylus', [
  	'--out', "#{publicPath}",
    '--watch', "#{srcPath}/stylus/screen.styl"
  ])

  process stylus, log
  return


task 'run:express', 'Run Express dev server.', (options) ->
  invoke 'watch:styl'

  package = stitch.createPackage(paths: stitchPaths)
  app = express.createServer(express.static(publicPath))
  port = options.port or 3333

  app.get('/js/app.js', package.createServer()).listen port
  console.log "Running Express dev server on port #{port}."
  return
