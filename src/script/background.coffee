apikey = 'cw5k0ng1j49ma4k1'

context = new AudioContext
source = null

chrome.ttsEngine.onSpeak.addListener (text, options, callback) ->

  chrome.storage.sync.get (items) ->
    unless items
      callback {type: 'error', errorMessage: 'No api key'}
      return
    
    request = new XMLHttpRequest
    url = 'https://api.voicetext.jp/v1/tts'
    request.open 'POST', url, true
    request.responseType = 'arraybuffer'
    basic = btoa items.api + ':'
    request.setRequestHeader 'Authorization', 'Basic ' + basic
    request.setRequestHeader 'Content-Type', 'application/x-www-form-urlencoded'
    request.onload = ->
      unless request.status == 200
        callback {type: 'error', errorMessage: 'Server error.'}
        return
      context.decodeAudioData request.response, (buffer) ->
        source = do context.createBufferSource
        source.buffer = buffer
        source.connect context.destination
        source.onended = ->
          callback {type: 'end'}
          return
        do source.start
    
    params = 'speaker=hikari&'
    params += 'text=' + encodeURIComponent(text)
    request.send params
    
chrome.ttsEngine.onStop.addListener ->
  if source
    do source.stop
  source = null