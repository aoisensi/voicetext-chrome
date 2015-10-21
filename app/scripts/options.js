'use strict';

document.addEventListener('DOMContentLoaded', function () {
  chrome.storage.sync.get({
    apikey: ''
  }, function (items) {
    document.getElementById('apikey').value = items.apikey;
  });
});

document.getElementById('save').addEventListener('click', function () {
  chrome.storage.sync.set({
    apikey: document.getElementById('apikey').value
  }, null);
});
//# sourceMappingURL=options.js.map
