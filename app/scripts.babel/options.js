'use strict';

document.addEventListener('DOMContentLoaded', () => {
  chrome.storage.sync.get({
    apikey: ''
  }, (items) => {
    document.getElementById('apikey').value = items.apikey;
  });
});

document.getElementById('save').addEventListener('click', () => {
  chrome.storage.sync.set({
    apikey: document.getElementById('apikey').value
  }, null);
});
