'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var AwebappGenerator = module.exports = function AwebappGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(AwebappGenerator, yeoman.generators.Base);

AwebappGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);
  cb();
};

AwebappGenerator.prototype.app = function app() {
  this.mkdir('app');
  this.mkdir('app/scripts');
  this.mkdir('app/styles');
  this.mkdir('app/images');

  this.copy('package.json',     'package.json');
  this.copy('bower.json',       'bower.json');
  this.copy('Gruntfile.coffee', 'Gruntfile.coffee');

  this.copy('index.html', 'app/index.html');
  this.copy('main.styl',  'app/styles/main.styl');
  this.copy('main.js',    'app/scripts/main.js');
};

AwebappGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('editorconfig', '.editorconfig');
  this.copy('jshintrc', '.jshintrc');
};
