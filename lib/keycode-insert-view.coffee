module.exports =
class KeycodeInsertView
  callback: null
  callbackScope: null
  element: null
  editorElement: null
  editor: null
  keydownKeyCode: null

  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('keycode-insert')

    # Create message element
    message = document.createElement('div')
    message.textContent = "Keycode insert"
    message.classList.add('message')
    @element.appendChild(message)

    @editorElement = document.createElement('atom-text-editor')
    @editor = atom.workspace.buildTextEditor({
      mini: true,
      lineNumberGutterVisible: false,
      placeholderText: "Please press the key you want to insert the code."
    })
    @editorElement.setModel(@editor)

    self = @
    @editorElement.onkeydown = (e) ->
      self.keydownKeyCode = e.keyCode

    @editorElement.onkeyup = (e) ->
      if e.keyCode == self.keydownKeyCode
        self.clear()
        self.callback?('' + e.keyCode, self.callbackScope)

    @element.appendChild(@editorElement)

  focus: ->
    @editorElement.focus()

  clear: ->
    @editor.setText('')
    @keydownKeyCode = null

  setCallback: (callback, scope) ->
    @callback = callback
    @callbackScope = scope

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
