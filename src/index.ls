class QiitaPatch
  ->
    header = document.getElementsByClassName(\teamHeader_inner)[0]
    container = document.getElementsByClassName(\teamMain_inner)[0]
    @main = document.getElementsByClassName(\teamSidebarContainer_main)[0]
    @sidebar = document.getElementsByClassName(\teamSidebarContainer_sub)[0]
    @fixWidth header
    @fixWidth container

  fixWidth: (elm)-> elm.setAttribute \style, 'width: 90%; max-width: 1200px;'

class QiitaPatchItem extends QiitaPatch
  ->
    super!
    @injectSidebarToggleButton!
    @sidebarToggle!
    @tableForceAuto!

  isSidebarHide: no

  injectSidebarToggleButton: ->
    header = document.getElementsByClassName(\teamArticle_header_actions)[0]

    toggleButton = document.createElement \li
    toggleButton.setAttribute \class, \teamArticle_header_action
    toggleButton.addEventListener \click, @sidebarToggle

    iconStyle = (color)-> "color: #{color}; cursor: pointer;"
    @icon = document.createElement 'i'
    @icon.setAttribute do
      \style
      iconStyle \#666
    @icon.addEventListener \mouseover, ~> @icon.setAttribute do
      \style
      iconStyle \#458ac5
    @icon.addEventListener \mouseout, ~> @icon.setAttribute do
      \style
      iconStyle \#666

    toggleButton.appendChild @icon
    header.appendChild toggleButton

  sidebarToggle: ~>
    @isSidebarHide = !@isSidebarHide

    if @isSidebarHide
      @sidebar.setAttribute \style, 'display: none;'
      @main.setAttribute \style, 'width: 100%;'
      @icon.setAttribute \class, 'fa fa-chevron-left'
    else
      @sidebar.removeAttribute \style
      @main.removeAttribute \style
      @icon.setAttribute \class, 'fa fa-chevron-right'

  tableForceAuto: ->
    Array.prototype.forEach.call do
      document.querySelectorAll \table
      (table)-> table.setAttribute \style, 'table-layout: auto; width: auto;'

class QiitaPatchDraft extends QiitaPatch
  ->
    super!
    @hideSubHeader!
    @fixHeight!

  hideSubHeader: ->
    document.getElementsByClassName(\teamSubHeader)[0].setAttribute \style, 'display: none;'

  fixHeight: ->
    getPositionTop = (elm, n=0)-> if elm.offsetParent? then getPositionTop elm.offsetParent, n + elm.offsetTop else n
    form = document.getElementsByClassName(\teamItemForm)[0]
    body = document.getElementById \draft_item_raw_body
    bodyTop = getPositionTop body
    miscHeight = (form.clientHeight - 128) - body.clientHeight
    body.setAttribute \style, "height: #{window.innerHeight - bodyTop - miscHeight}px;"

switch
  when location.pathname is \/ then new QiitaPatch!
  when location.pathname.split(\/)[1] is \drafts then new QiitaPatchDraft!
  when location.pathname.split(\/)[2] is \items then new QiitaPatchItem!
