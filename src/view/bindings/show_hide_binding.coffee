#= require ./abstract_binding

class Batman.DOM.ShowHideBinding extends Batman.DOM.AbstractBinding
  onlyObserve: Batman.BindingDefinitionOnlyObserve.Data

  constructor: (definition) ->
    display = definition.node.style.display
    display = '' if not display or display is 'none'
    @originalDisplay = display

    {@invert} = definition
    super

  dataChange: (value) ->
    view = Batman.View.viewForNode(@node, false)

    if !!value is not @invert
      view?.fire('viewWillShow')
      @node.style.display = @originalDisplay
      view?.fire('viewDidShow')
    else
      view?.fire('viewWillHide')
      Batman.DOM.setStyleProperty(@node, 'display', 'none', 'important')
      view?.fire('viewDidHide')
