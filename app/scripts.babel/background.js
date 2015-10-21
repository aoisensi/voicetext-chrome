'use strict';

var player = document.getElementById('player');

var ENDPOINT = 'https://api.voicetext.jp/v1/tts';

var VOICE_MAP = {
    'VoiceText Show': 'show',
    'VoiceText Haruka': 'haruka',
    'VoiceText Hikari': 'hikari',
    'VoiceText Takeru': 'takeru',
    'VoiceText Santa': 'santa',
    'VoiceText Bear': 'bear'
};

chrome.ttsEngine.onSpeak.addListener((utterance, options, sendTtsEvent) => {
  console.log(options.voiceName);
  var xhr = new XMLHttpRequest();
  var params = 'speaker=' + VOICE_MAP[options.voiceName];
  params += '&text=' + encodeURIComponent(utterance);
  xhr.responseType = 'arraybuffer';
  xhr.onload = () => {
    var blob = new Blob([xhr.response], {type: 'audio/wav'});
    var object = URL.createObjectURL(blob);
    player.src = object;
    player.onload = () => {
      URL.revokeObjectURL(object);
    };
    player.load();
    sendTtsEvent({'type': 'start'});
    player.play();
  };
  xhr.onerror = (e) => {
    console.log(e);
  };
  xhr.open('POST', ENDPOINT, true);
  xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  chrome.storage.sync.get('apikey', (items) => {
    xhr.setRequestHeader('Authorization', 'Basic ' + btoa(items.apikey + ':'));
    xhr.send(params);
  });
});

chrome.ttsEngine.onStop.addListener(() => {
  player.pause();
});
