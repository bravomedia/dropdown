jQuery Dropdown Plugin
========

Simple responsive jQuery plugin to handle dropdowns.

Depends on [jGestures](http://jgestures.codeplex.com/)

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

action: defaults to hover

hoverClass: defaults to hover

activeClass: defaults to active

animationTime: defaults to slow

touchElement: defaults to a

touchedClass: defaults to touched

itemSelector: defaults to li

dropdownSelector: defaults to ul

activatedCallback: callback called on successful activation

activeCallback: callback called when animation is complete on action

