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

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'keycode-insert:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @keycodeInsertView.destroy()

  serialize: ->
    keycodeInsertViewState: @keycodeInsertView.serialize()

  toggle: ->
    console.log 'KeycodeInsert was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
