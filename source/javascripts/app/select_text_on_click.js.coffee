jQuery ($) ->
  $('.select-text-on-click').focus ->
    $this = $ @
    $this.select()
    # Chrome bug workaround
    $this.mouseup ->
      $this.unbind("mouseup")
      false