/* global window:true localStorage document */
/* eslint import/no-unresolved: [2, { ignore: ['vulcanize'] }] */


/* eslint import/no-extraneous-dependencies: [0, {"devDependencies": false,
"optionalDependencies": true, "peerDependencies": true}] */

const jwt = require('./js/jwtHelper');

// Require your main webcomponent file (that can be just a
// file filled with html imports, custom styles or whatever)
require('vulcanize?es6=false&base=./&watchFolders=./static!./imports.html');

// Require our styles
require('./main.css');

require('./normalize.css');

const Elm = require('./Main.elm');

window.Polymer = {
  dom: 'shadow',
  lazyRegister: true,
  useNativeCSSProperties: true,
};


window.addEventListener('WebComponentsReady', () => {
  const root = document.getElementById('root');

  let app;
  const apiKey = localStorage.getItem('apiKey');

  if (apiKey && !jwt.isTokenExpired(apiKey)) {
    app = Elm.Main.embed(root, { apiKey });
  } else {
    app = Elm.Main.embed(root, { apiKey: null });
  }

  // Ports

  app.ports.storeApiKey.subscribe(data => localStorage.setItem('apiKey', data));

  // Find the Paper Toast (there should be only one)
  function getPaperToast() {
    return document.getElementsByTagName('paper-toast')[0];
  }

  function getPaperDialog() {
    return document.getElementsByTagName('paper-dialog')[0];
  }

  app.ports.openToast.subscribe(() => {
    // Find the paper toast and call open on it
    getPaperToast().open();
  });

  app.ports.openDialog.subscribe(() => {
    getPaperDialog().open();
  });

  app.ports.closeDialog.subscribe(() => {
    getPaperDialog().close();
  });
});
