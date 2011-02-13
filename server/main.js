var fs = require('fs');

var app = exports.app = require('stick').Application()
        .configure('error', 'notfound', 'modulr/middleware', 'static');

app.modulr(module.resolve(fs.join('..', 'public', 'app')), '/app');

app.static(module.resolve(fs.join('..', 'public')), 'index.html');

if (require.main === module) {
    require('stick/server').main(module.id);
}
