// Fade while the player's collision mask overlaps the temple's collision mask bounds.
templeSolidAlpha = 1;
templeFadeAlpha = 0.42;
templeFadeLerp = 0.18;

// The temple sprite uses a bottom-center origin.
templeBaseDepthOffset = 0;

image_alpha = templeSolidAlpha;
depth = -floor(y - templeBaseDepthOffset);
