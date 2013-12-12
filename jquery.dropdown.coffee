$ = jQuery

$.fn.dropdown = (options) ->

    self = this

    # Create some defaults, extending them with any options that were provided. 
    # 
    # Settings:
    # action: defaults to hover
    # hoverClass: defaults to hover
    # activeClass: defaults to active
    # animationTime: defaults to slow
    # touchElement: defaults to a
    # touchedClass: defaults to touched
    # itemSelector: defaults to li
    # dropdownSelector: defaults to ul
    # activatedCallback: callback called on successful activation
    # activeCallback: callback called when animation is complete on action

    # Merge default settings with options
    settings = $.extend
        action:'hover'
        hoverClass:'hover'
        activeClass:'active'
        animationTime:'fast'
        touchElement:'a'
        touchedClass:'touched'
        itemSelector:'li'
        dropdownSelector:'ul'
    , options

    if settings.action == 'click'
        $(this).find(settings.itemSelector).not('.'+settings.activeClass).find(settings.dropdownSelector).slideUp(1, ->
            # Call callback if defined
            if (settings.activatedCallback) 
                settings.activatedCallback(self)
            )
        
        $(this).find(settings.itemSelector).on('click', '>'+settings.touchElement, ->
            $(this).siblings(settings.dropdownSelector).slideToggle(settings.animationTime, ->
                # Call callback if defined
                if (settings.activeCallback) 
                    settings.activeCallback(self)
            )
        )
    else if settings.action == 'hover'
        # Only select first level children
        if settings.itemSelector == 'li'
            settings.itemSelector = '>ul>li'

        # Slide menus up, default state
        $(this).find(settings.itemSelector).find(settings.dropdownSelector).slideUp(1, ->
            # Call callback if defined
            if settings.activatedCallback
                settings.activatedCallback(self)
        )

        $(this).find(settings.itemSelector).hover( ->
            clearTimeout($.data(this, 'timer'))
            $(settings.dropdownSelector, this).stop(true, true).slideDown(settings.animationTime, ->
                # Call callback if defined
                if settings.activeCallback 
                    settings.activeCallback(self)
            )
            $(this).addClass(settings.hoverClass).children(settings.touchElement).removeClass(settings.touchedClass)
            
        , ->
            $.data(this, 'timer', setTimeout($.proxy(->
                $(settings.dropdownSelector, this).stop(true, true).slideUp(settings.animationTime, ->
                    # Call callback if defined
                    if settings.activeCallback 
                        settings.activeCallback(self)
                )
                $(this).removeClass(settings.hoverClass).children(settings.touchElement).addClass(settings.touchedClass)
            , this), settings.animationTime))
        )

    # Enable user to "touch" outside of dropdown to collapse again.
    $("*").bind('tapone', (e) ->
        container = $('.'+settings.hoverClass)
        if container.length
            if $(this).parents().hasClass(settings.hoverClass)
                e.stopPropagation()
            else
                e.preventDefault()
                e.stopPropagation()

        if container.has(e.target).length == 0
            container.mouseleave()
    )

    # Enable user to still be able to click the parent link.
    $(settings.touchElement).bind('tapone', (e) ->
        if $(this).hasClass(settings.touchedClass)
            if $(this).parent('.' + settings.hoverClass).length == 0
                e.preventDefault()
                $(this).removeClass(settings.touchedClass).parent().mouseenter()
    )

    this