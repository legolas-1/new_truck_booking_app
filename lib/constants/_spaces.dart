//TODO: make constants using below reference and define a base unit like 5px and
//calculate rest of them. why are we doing this ? so then in code doing like
//height: 10px, we will just say height: --space-xs
//This way will minimize code errors.

{
	/* spacing values */
	--space-unit: 5px;
	--space-xxs: calc(1 * var(--space-unit)); // 5
	--space-xs: calc(2 * var(--space-unit)); // 10
	--space-sm: calc(3 * var(--space-unit)); // 15
	--space-md: calc(4 * var(--space-unit)); // 20
	--space-lg: calc(5 * var(--space-unit)); // 25
	--space-xl: calc(6 * var(--space-unit)); // 30
	--space-xxl: calc(7 * var(--space-unit)); // 35
	--space-xxxl: calc(8 * var(--space-unit)); // 40
	--space-xxxxl: calc(10 * var(--space-unit)); // 50
}
