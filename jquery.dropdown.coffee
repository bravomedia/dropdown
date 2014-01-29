$ = jQuery

$.fn.dropdown = (options) ->

    self = this

    # Default Settings:
    # action: defaults to hover
    # hoverClass: defaults to hover
    # activeClass: defaults to active
    # animationTime: defaults to slow
    # touchElement: defaults to a
    # touchedClass: defaults to touched
    # itemSelector: defaults to li
    # dropdownSelector: defaults to ul

    # Merge default settings with options
    settings = $.extend
        action:'hover'
        hoverClass:'hover'
        activeClass:'active'
        animationEffect:'slide'
        animationTime:'fast'
        touchElement:'a'
        touchedClass:'touched'
        itemSelector:'li'
        dropdownSelector:'ul'
    , options

    switch settings.action
        when 'click'
            $(this).find(settings.itemSelector).not('.' + settings.activeClass).find(settings.dropdownSelector).hide 1, ->
                # Trigger event
                self.trigger 'dropdownLoaded', 
                    object: self
            
            $(this).find(settings.itemSelector).on 'click', '>' + settings.touchElement, ->
                $(this).siblings(settings.dropdownSelector).slideToggle settings.animationTime, ->
                    # Trigger event
                    self.trigger 'dropdownItemActive', 
                        activeObject: $(this)

        else
            # Only select first level children
            if settings.itemSelector is 'li'
                settings.itemSelector = '>ul>li'

            # Slide menus up, default state
            $(this).find(settings.itemSelector).find(settings.dropdownSelector).hide 1, ->
                # Trigger event
                self.trigger 'dropdownLoaded', 
                    object: self

            $(this).find(settings.itemSelector).hover ->
                clearTimeout($.data(this, 'timer'))

                # Switch for animation effect
                switch settings.animationEffect
                    when 'fade'
                        $(settings.dropdownSelector, this).stop(true, true).fadeIn settings.animationTime, ->
                            # Trigger event
                            self.trigger 'dropdownItemActivated', 
                                activeObject: this
                    else
                        $(settings.dropdownSelector, this).stop(true, true).slideDown settings.animationTime, ->
                            # Trigger event
                            self.trigger 'dropdownItemActivated', 
                                activeObject: this

                $(this).addClass(settings.hoverClass).children(settings.touchElement).removeClass(settings.touchedClass)
                
            , ->
                $.data(this, 'timer', setTimeout($.proxy(->
                    # Switch for animation effect
                    switch settings.animationEffect
                        when 'fade'
                            $(settings.dropdownSelector, this).stop(true, true).fadeOut settings.animationTime, ->
                                # Trigger event
                                self.trigger 'dropdownItemDeactivated', 
                                    activeObject: $(this)
                        else
                            $(settings.dropdownSelector, this).stop(true, true).slideUp settings.animationTime, ->
                                # Trigger event
                                self.trigger 'dropdownItemDeactivated', 
                                    activeObject: $(this)

                    $(this).removeClass(settings.hoverClass).children(settings.touchElement).addClass(settings.touchedClass)
                , this), settings.animationTime))

    # Enable user to "touch" outside of dropdown to collapse again.
    $("*").bind 'tap', (e) ->
        container = $('.'+settings.hoverClass)
        if container.length
            if $(this).parents().hasClass(settings.hoverClass)
                e.stopPropagation()
            else
                e.preventDefault()
                e.stopPropagation()

        if container.has(e.target).length == 0
            container.mouseleave()

    # Enable user to still be able to click the parent link.
    $(settings.touchElement).bind 'tap', (e) ->
        if $(this).hasClass(settings.touchedClass)
            if $(this).parent('.' + settings.hoverClass).length == 0
                e.preventDefault()
                $(this).removeClass(settings.touchedClass).parent().mouseenter()

    return this