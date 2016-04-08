KeycodeInsertView = require './keycode-insert-view'
{CompositeDisposable} = require 'atom'

module.exports = KeycodeInsert =
  keycodeInsertView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @keycodeInsertView = new KeycodeInsertView(state.keycodeInsertViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @keycodeInsertView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that runs this function
    @subscriptions.add atom.commands.add 'atom-workspace', 'keycode-insert:insert': => @insert()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @keycodeInsertView.destroy()

  serialize: ->
    keycodeInsertViewState: @keycodeInsertView.serialize()

  insert: ->
    @keycodeInsertView.setCallback(@afterInsert.bind(@))
    @modalPanel.show()
    @keycodeInsertView.focus()

  afterInsert: (value) ->
    @modalPanel.hide()
    atom.workspace.getActivePane().activate()
    activeEditor = atom.workspace.getActiveTextEditor()
    activeEditor.insertText(value, select: true)
