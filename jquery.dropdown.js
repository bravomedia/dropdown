;(function( $ ){

	$.fn.dropdown = function( options ) {  

		var self = this;

		/* Create some defaults, extending them with any options that were provided.
		 * Settings:
		 * action: defaults to hover
		 * hoverClass: defaults to hover
		 * activeClass: defaults to active
		 * animationTime: defaults to slow
		 * touchElement: defaults to a
		 * touchedClass: defaults to touched
		 * itemSelector: defaults to li
		 * dropdownSelector: defaults to ul
		 * activatedCallback: callback called on successful activation
		 * activeCallback: callback called when animation is complete on action
		 */
		var settings = $.extend( {
			'action':'hover',
			'hoverClass':'hover',
			'activeClass':'active',
			'animationTime':'slow',
			'touchElement':'a',
			'touchedClass':'touched',
			'itemSelector':'li',
			'dropdownSelector':'ul'
		}, options);
		
		// Action click
		if (settings.action === 'click') {
			// Slide menus up if not active, default state
			$(this).find(settings.itemSelector).not('.'+settings.activeClass).find(settings.dropdownSelector).slideUp(1, function() {
				// Call callback if defined
				if (settings.activatedCallback) settings.activatedCallback(self);
			});
			
			$(this).find(settings.itemSelector).children(settings.touchElement).click( function () {
				$(this).siblings(settings.dropdownSelector).slideToggle(settings.animationTime, function() {
					// Call callback if defined
					if (settings.activeCallback) settings.activeCallback(self);
				});
			});

		// Action hover
		} else if (settings.action === 'hover') {
			// Slide menus up, default state
			$(this).find(settings.itemSelector).find(settings.dropdownSelector).slideUp(1, function() {
				// Call callback if defined
				if (settings.activatedCallback) settings.activatedCallback(self);
			});

			$(this).find(settings.itemSelector).hover( function () {
				clearTimeout($.data(this, 'timer'));
				$(settings.dropdownSelector, this).stop(true, true).slideDown(settings.animationTime, function() {
					// Call callback if defined
					if (settings.activeCallback) settings.activeCallback(self);
				});
				$(this).addClass(settings.hoverClass).children(settings.touchElement).removeClass(settings.touchedClass);
				
			}, function () {
				$.data(this, 'timer', setTimeout($.proxy(function() {
					$(settings.dropdownSelector, this).stop(true, true).slideUp(settings.animationTime, function() {
						// Call callback if defined
						if (settings.activeCallback) settings.activeCallback(self);
					});
					$(this).removeClass(settings.hoverClass).children(settings.touchElement).addClass(settings.touchedClass);
				}, this), settings.animationTime));
			});
		}

		// Enable user to "touch" outside of dropdown to collapse again.
		$("*").bind('tapone', function(e) {
			var container = $('.'+settings.hoverClass);
			if(container.length) {
				if($(this).parents().hasClass(settings.hoverClass)){
					e.stopPropagation();
				} else {
					e.preventDefault();
					e.stopPropagation();
				}
			}
			if (container.has(e.target).length === 0)
			{
				container.mouseleave();
			}
		});

		// Enable user to still be able to click the parent link.
		$(settings.touchElement).bind('tapone', function(e) {
			if($(this).hasClass(settings.touchedClass)) {
				if($(this).parent('.' + settings.hoverClass).length === 0) {
					e.preventDefault();
					$(this).removeClass(settings.touchedClass).parent().mouseenter();
				}
			}
		});

		// Return this to enable chaining
		return this;
	};
})( jQuery );