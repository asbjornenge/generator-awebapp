require.config({
    baseUrl : '../app/',
    paths: {
    },
    urlArgs: "v="+(new Date()).getTime()
});

require([
    '../test/spec.js',
],
function() {
    mocha.run()
});

