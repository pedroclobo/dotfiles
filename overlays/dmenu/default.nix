self: super: {
	dmenu = super.dmenu.overrideAttrs (oldAttrs: {
		patches = [
			(super.fetchpatch {
				url =
					"http://tools.suckless.org/dmenu/patches/line-height/dmenu-lineheight-5.2.diff";
				sha256 = "QdY2T/hvFuQb4NAK7yfBgBrz7Ii7O7QmUv0BvVOdf00=";
			})
			(super.fetchpatch {
				url =
					"http://tools.suckless.org/dmenu/patches/numbers/dmenu-numbers-20220512-28fb3e2.diff";
				sha256 = "lg7CItn11YPEe7T7aPt1DBybZlnLjKQGC8J+OcY44Js=";
			})
			./colors.diff
			./fonts.diff
			./top-bar.diff
			./line-height.diff
		];
	});
}
