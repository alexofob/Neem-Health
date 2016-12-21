/* global window:true localStorage document */

// Require your main webcomponent file (that can be just a
// file filled with html imports, custom styles or whatever)
require('vulcanize?es6=false&base=./&watchFolders=./static!./imports.html');

// Require our styles
require('./main.css');

require('./normalize.css');

const Elm = require('./Main.elm');

let app;

window.Polymer = {
  dom: 'shadow',
  lazyRegister: true,
  useNativeCSSProperties: true,
};


window.addEventListener('WebComponentsReady', () => {
  const apiKey = localStorage.getItem('apiKey');
  const root = document.getElementById('root');

  if (apiKey) {
    app = Elm.Main.embed(root, { apiKey });
  } else {
    app = Elm.Main.embed(root, { apiKey: null });
  }
});


app.ports.storeApiKey.subscribe(data => localStorage.setItem('apiKey', data));
