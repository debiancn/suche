Suche

======

A simple json search server with Ruby builtin `webrick`.

#### Layouts

* app: the ruby stuff, should be protected with your .htaccess
* public: everything public to the outside
* - css
* - js: effects.js, controls.js and prototype.js are from script.aculo.us/downloads. prototype is modified to fix a little bug mentioned here: http://stackoverflow.com/questions/7094249/scriptaculous-autocompleter-result-list-position-problem

The actual static html is parsed by Ruby `erb` templates.

#### LICENSE

LGPL-3.0
