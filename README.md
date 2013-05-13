jQuery Dropdown Plugin
========

Simple responsive jQuery plugin to handle dropdowns.

Example HTML markup:
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

Just call it like any other jQuery method, like so:
$('nav').dropdown();

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

