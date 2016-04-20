api = document.getElementById 'apikey'
save = document.getElementById 'save'
status = document.getElementById 'status'

document.addEventListener 'DOMContentLoaded', ->
  chrome.storage.sync.get
    api: ''
  , (items) ->
    api.value = items.api

save.addEventListener 'click', ->
  chrome.storage.sync.set
    api: api.value
  , ->
    status.textContent = 'Saved!!'