## File Structure

```
static/css/
├── base.css         # Variables, reset, typography, base elements
├── layout.css       # Grid, sidebar, main content layout, mobile-first  
├── components.css   # Buttons, cards, navigation, creator info
├── responsive.css   # All media queries consolidated (mobile-first)
└── site.css         # Main file that imports all modules
```

## Breakpoint Strategy

```css
:root {
  --breakpoint-sm: 480px;   /* Small screens and up */
  --breakpoint-md: 768px;   /* Tablets and up */
  --breakpoint-lg: 1024px;  /* Desktop and up */
  --breakpoint-xl: 1200px;  /* Large desktop and up */
}
```
