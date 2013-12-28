/*global describe, beforeEach, it*/
'use strict';

var path    = require('path');
var helpers = require('yeoman-generator').test;


describe('awebapp generator', function () {
  beforeEach(function (done) {
    helpers.testDirectory(path.join(__dirname, 'temp'), function (err) {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator('awebapp:app', [
        '../../app'
      ]);
      done();
    }.bind(this));
  });

  it('creates expected files', function (done) {
    var expected = [
      'package.json',
      'bower.json',
      'Gruntfile.coffee',
      '.editorconfig',
      'assets/app/index.html',
      'assets/app/styles/main.styl',
      'assets/app/scripts/main.js',
      'assets/test/spec.js',
      'assets/test/specRunner.js',
      'assets/test/index.html'
    ];

    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFiles(expected);
      done();
    });
  });
});
