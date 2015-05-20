$( document ).on 'ready page:load', ->
  currentLocation = window.location.pathname
  currentTab      = $( "ul.nav a[href='#{ currentLocation }']" )

  currentTab.parent().addClass 'active'
