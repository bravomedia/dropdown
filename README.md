jQuery Dropdown Plugin
========

Simple responsive jQuery plugin to handle dropdowns. Now in [CoffeeScript](http://coffeescript.org/)!

Depends on [jGestures](http://jgestures.codeplex.com/).

Right now all levels matching the criteria (dropdownSelector) and markup will collapse, there will soon be an option to set how many levels to collapse.

Example HTML markup:
```html
<nav>
	<ul>
		<li>
			<a>Menu item</a>
			<ul>
				<li>
					<a>Submenu item</a>
				</li>
			</ul>
		</li>
	</ul>
</nav>
```
Just call it like any other jQuery method, like so:
```javascript
$('nav').dropdown();
```

Settings:

action: On which event to trigger (defaults to hover)

hoverClass: Class to add on hover (defaults to hover)

activeClass: Class used for active menu items, needed for action: 'click' (defaults to active)

animationTime: Animation time for dropdown slide (defaults to fast)

touchElement: Touch item (defaults to a)

touchedClass: Class to indicate touched-state (defaults to touched)

itemSelector: Item to hover/click (defaults to li)

dropdownSelector: Items to collapse (defaults to ul)

activatedCallback: Callback called on successful activation

activeCallback: Callback called when animation is complete on action

