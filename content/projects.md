---js
const eleventyNavigation = {
	key: "Projects",
	order: 2
};
---
# Projects

<div class="projects-grid">
	<div class="project-card">
		<div class="project-cover">
			<picture>
				<source type="image/webp" srcset="/img/reflect-cover-1000.webp 1x, /img/reflect-cover-2000.webp 2x, /img/reflect-cover-3000.webp 3x">
				<source type="image/png" srcset="/img/reflect-cover-1000.png 1x, /img/reflect-cover-2000.png 2x, /img/reflect-cover-3000.png 3x">
				<img src="/img/reflect-cover-1000.png" alt="Reflect Calendar cover">
			</picture>
		</div>
		<div class="project-content">
			<h3 class="project-title"><a href="https://reflectcal.com/guest" target="_blank">Reflect Calendar</a></h3>
			<p class="project-description">A fast and minimalist web calendar designed for productivity and simplicity. Built with performance in mind, it offers a clean interface for managing your schedule without the bloat.<br><br>Stack: JavaScript, HTML5, CSS3, <a href="https://github.com/google/closure-library" target="_blank">Closure Library</a>, <a href="https://developers.google.com/closure/compiler" target="_blank">Closure Compiler</a>, <a href="https://github.com/google/closure-templates" target="_blank">Closure Templates</a>, Node.js, Express.js, MongoDB, Docker</p>
			<a href="https://reflectcal.com/guest" class="project-link" target="_blank">Visit Project →</a>
		</div>
	</div>
	<div class="project-card">
		<div class="project-cover">
			<picture>
				<source type="image/webp" srcset="/img/radzima-cover-1000.webp 1x, /img/radzima-cover-2000.webp 2x, /img/radzima-cover-3000.webp 3x">
				<source type="image/png" srcset="/img/radzima-cover-1000.png 1x, /img/radzima-cover-2000.png 2x, /img/radzima-cover-3000.png 3x">
				<img src="/img/radzima-cover-1000.png" alt="Radzima.app screenshots showing three different screens">
			</picture>
		</div>
		<div class="project-content">
			<h3 class="project-title"><a href="https://radzima.app/" target="_blank">Radzima.app</a></h3>
			<p class="project-description">An iOS native application for internal tourism activities in Belarus, specifically for visiting places of nature. Features more than 500 national parks, historical sites and landmarks of Belarus, biking and walking routes, and various tours.<br><br>Stack: Objective-C, UIKit, CoreData, Mapbox, Firebase, AWS Amplify, CocoaPods, Fastlane</p>
			<a href="https://radzima.app/" class="project-link" target="_blank">Visit Project →</a>
		</div>
	</div>
	<div class="project-card">
		<div class="project-cover">
			<picture>
				<source type="image/webp" srcset="/img/cube-carousel-cover-1000.webp 1x, /img/cube-carousel-cover-2000.webp 2x, /img/cube-carousel-cover-3000.webp 3x">
				<source type="image/png" srcset="/img/cube-carousel-cover-1000.png 1x, /img/cube-carousel-cover-2000.png 2x, /img/cube-carousel-cover-3000.png 3x">
				<img src="/img/cube-carousel-cover-1000.png" alt="Cube carousel UI showing rotating cube interface">
			</picture>
		</div>
		<div class="project-content">
			<h3 class="project-title"><a href="https://github.com/alexeykomov/cube-carousel" target="_blank">Cube Carousel</a></h3>
			<p class="project-description">A smooth rotating cube UI similar to <a href="https://about.instagram.com/blog/announcements/introducing-instagram-stories" target="_blank">Instagram Stories</a>, where each edge displays an image or video. Built with <a href="https://developer.apple.com/documentation/uikit/uicollectionview" target="_blank">UICollectionView</a> for fluid scrolling and rotation animations.<br><br>Stack: Objective-C, UIKit (UICollectionView), Core Animation (<a href="https://developer.apple.com/documentation/quartzcore/catransform3d?language=objc" target="_blank">CATransform3D</a>)</p>
			<a href="https://github.com/alexeykomov/cube-carousel" class="project-link" target="_blank">Visit Project →</a>
		</div>
	</div>
	<div class="project-card">
		<div class="project-cover">
			<picture>
				<!-- Dark mode cover -->
				<source media="(prefers-color-scheme: dark)" type="image/webp" srcset="/img/scr-cover-dark-1000.webp 1x, /img/scr-cover-dark-2000.webp 2x, /img/scr-cover-dark-3000.webp 3x">
				<source media="(prefers-color-scheme: dark)" type="image/png" srcset="/img/scr-cover-dark-1000.png 1x, /img/scr-cover-dark-2000.png 2x, /img/scr-cover-dark-3000.png 3x">
				<!-- Light mode cover (default) -->
				<source type="image/webp" srcset="/img/scr-cover-1000.webp 1x, /img/scr-cover-2000.webp 2x, /img/scr-cover-3000.webp 3x">
				<source type="image/png" srcset="/img/scr-cover-1000.png 1x, /img/scr-cover-2000.png 2x, /img/scr-cover-3000.png 3x">
				<img src="/img/scr-cover-1000.png" alt="Telegram Chart Contest interface showing interactive charts">
			</picture>
		</div>
		<div class="project-content">
			<h3 class="project-title"><a href="https://alexeykomov.github.io/chart-contest/" target="_blank">Telegram Chart Contest</a></h3>
			<p class="project-description">JavaScript charting application developed for <a href="https://t.me/contest/6" target="_blank">Telegram's official coding competition</a>. Built from scratch without specialized charting libraries. I didn't <a href="https://t.me/contest/58">win</a> any prize, but it was good opportunity to learn more about <a href="https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API">Canvas API</a>. I was thinking of extending these charts to a full-fledged charting library someday.<br><br>Stack: JavaScript, HTML5, CSS3, Canvas API</p>
			<a href="https://alexeykomov.github.io/chart-contest/" class="project-link" target="_blank">Visit Project →</a>
		</div>
	</div>
	<div class="project-card">
		<div class="project-cover">
			<picture>
				<!-- Dark mode cover -->
				<source media="(prefers-color-scheme: dark)" type="image/webp" srcset="/img/pythagoras-tree-cover-dark-1000.webp 1x, /img/pythagoras-tree-cover-dark-2000.webp 2x, /img/pythagoras-tree-cover-dark-3000.webp 3x">
				<source media="(prefers-color-scheme: dark)" type="image/png" srcset="/img/pythagoras-tree-cover-dark-1000.png 1x, /img/pythagoras-tree-cover-dark-2000.png 2x, /img/pythagoras-tree-cover-dark-3000.png 3x">
				<!-- Light mode cover (default) -->
				<source type="image/webp" srcset="/img/pythagoras-tree-cover-1000.webp 1x, /img/pythagoras-tree-cover-2000.webp 2x, /img/pythagoras-tree-cover-3000.webp 3x">
				<source type="image/png" srcset="/img/pythagoras-tree-cover-1000.png 1x, /img/pythagoras-tree-cover-2000.png 2x, /img/pythagoras-tree-cover-3000.png 3x">
				<img src="/img/pythagoras-tree-cover-1000.png" alt="Pythagoras tree fractal visualization">
			</picture>
		</div>
		<div class="project-content">
			<h3 class="project-title"><a href="https://alexeykomov.github.io/pythagoras-tree/" target="_blank">Pythagoras Tree</a></h3>
			<p class="project-description">This is a <a href="https://en.wikipedia.org/wiki/Pythagoras_tree_(fractal)" target="_blank">Pythagoras tree fractal</a> built with SVG. Notable thing about this experiment is that it is using Closure Compiler's <a href="https://developers.google.com/closure/compiler/docs/api-tutorial3">advanced compilation mode</a> with React. This was done using <a href="https://blog.persistent.info/" target="_blank">Mihai Parparita</a>'s <a href="https://github.com/mihaip/react-closure-compiler">modification</a> of Closure Compiler.<br><br>Stack: JavaScript, React, SVG, Closure Compiler</p>
			<a href="https://alexeykomov.github.io/pythagoras-tree/" class="project-link" target="_blank">Visit Project →</a>
		</div>
	</div>
	<div class="project-card">
		<div class="project-cover">
			<picture>
				<!-- Dark mode cover -->
				<source media="(prefers-color-scheme: dark)" type="image/webp" srcset="/img/fifteen-cover-dark-1000.webp 1x, /img/fifteen-cover-dark-2000.webp 2x, /img/fifteen-cover-dark-3000.webp 3x">
				<source media="(prefers-color-scheme: dark)" type="image/jpeg" srcset="/img/fifteen-cover-dark-1000.jpg 1x, /img/fifteen-cover-dark-2000.jpg 2x, /img/fifteen-cover-dark-3000.jpg 3x">
				<!-- Light mode cover (default) -->
				<source type="image/webp" srcset="/img/fifteen-cover-1000.webp 1x, /img/fifteen-cover-2000.webp 2x, /img/fifteen-cover-3000.webp 3x">
				<source type="image/jpeg" srcset="/img/fifteen-cover-1000.jpg 1x, /img/fifteen-cover-2000.jpg 2x, /img/fifteen-cover-3000.jpg 3x">
				<img src="/img/fifteen-cover-1000.jpg" alt="Fifteen puzzle game interface">
			</picture>
		</div>
		<div class="project-content">
			<h3 class="project-title"><a href="https://alexeykomov.github.io/fifteen/" target="_blank">Fifteen Puzzle</a></h3>
			<p class="project-description">Fifteen puzzle. What's interesting about this experiment is that it's written in <a href="https://clojurescript.org/" target="_blank">ClojureScript</a> using <a href="https://reagent-project.github.io/" target="_blank">Reagent</a>. Rules can be overviewed at <a href="https://en.wikipedia.org/wiki/15_puzzle" target="_blank">Wikipedia</a>.<br><br>Stack: ClojureScript, Reagent, HTML5, CSS3</p>
			<a href="https://alexeykomov.github.io/fifteen/" class="project-link" target="_blank">Visit Project →</a>
		</div>
	</div>
</div>

