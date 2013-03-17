# Core library / utility.
#
#= require mercury/extensions/number
#= require mercury/extensions/string
#
#= require mercury/core/config
#= require mercury/core/events
#= require mercury/core/i18n
#= require mercury/core/logger
#= require mercury/core/model
#= require mercury/core/module
#= require mercury/core/region
#= require mercury/core/view
#
# Views.
#
#= require mercury/views/editor
#= require mercury/views/uploader
#
# Region modules.
#
#= require mercury/regions/modules/drop_indicator
#= require mercury/regions/modules/text_selection
#= require mercury/regions/modules/focusable_textarea
globalize = ->

  # Extends the global Mercury object with various modules.
  #
  # In general it's expected that you use the methods provided on the Mercury namespace, and don't call through to the
  # modules directly.
  #
  # A good example of this is the Mercury.I18n module. It's recommended that you use Mercury.t and not Mercury.I18n.t, or
  # similarly with Mercury.Logger -- use Mercury.log (or this.log in models and views etc.) instead of Mercury.Logger.log
  # as the context may not be the same.
  #
  @version = '1.0.0'

  # Add global configuration methods.
  #
  # Mercury.configure
  # Creates or updates configuration values. Accepts a path (eg. 'localization:preferred') and a value to be set.
  #
  # Mercury.config
  # Get a configuration value by providing a path (much like the setter).
  #
  @Module.extend.call(@, @Config)
  @configure = @Config.set

  # Add global event handling/triggering.
  #
  # The event engine generally mimics jQuery style of binding and unbinding.
  #
  # Mercury.on
  # Binds to a global event. Not every event is global, but many are piped through globally so you can bind to them.
  #
  # Mercury.one
  # Same as Mercury.on, but will be removed after the first time the event is triggered.
  #
  # Mercury.trigger
  # Trigger a global event.
  #
  # Mercury.off
  # Stop observing a given global event.
  #
  @Module.extend.call(@, @Events)

  # Add global translation.
  #
  # Mercury.t
  # Translate a given string with simple printf-like handling.
  #
  @Module.extend.call(@, @I18n)

  # Add global logger.
  #
  # Mercury.log
  # Logs the provided information using console.log if available.
  #
  # Mercury.notify
  # Logs a given message using console.error (and console.trace) if available, otherwise an exception is thrown.
  #
  @Module.extend.call(@, @Logger)

  # Do some detection.
  #
  # We need to detect various support, and as nice as it would be to feature detection some of the more complex aspects
  # aren't something that you can detect for (eg. drag and drop event propagation.
  #
  @support =
    webkit: navigator.userAgent.indexOf('WebKit') > 0
    gecko: navigator.userAgent.indexOf('Firefox') > 0
    ie: if isIE = navigator.userAgent.match(/MSIE\s([\d|\.]+)/) then parseFloat(isIE[1], 10) else false

globalize.call(Mercury)
