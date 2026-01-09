# Design Token Extractor

When analyzing a screenshot or design reference, extract the following tokens:

## How to Use

When the user provides a screenshot, analyze it carefully and extract:

### 1. Colors

Look at the image and identify:

```
BACKGROUNDS
- Primary background (usually the darkest, main page bg)
- Secondary background (cards, containers)
- Tertiary background (inputs, nested elements)
- Overlay/modal backgrounds

TEXT
- Primary text (headings, important text)
- Secondary text (body, descriptions)
- Muted text (timestamps, meta info)
- Link text

ACCENTS
- Primary accent (buttons, active states)
- Secondary accent (hover states, highlights)
- Success (green indicators)
- Warning (yellow/orange indicators)
- Error (red indicators)

BORDERS
- Default border color
- Focus border color
- Divider color
```

### 2. Spacing

Estimate spacing values based on visual gaps:

```
- Component padding (inside cards, buttons)
- Gap between elements
- Section margins
- Container padding
```

### 3. Border Radius

```
- Buttons (usually md-lg)
- Cards (usually lg-xl)
- Avatars (usually full)
- Inputs (usually md)
- Tags/badges (usually full or lg)
```

### 4. Typography

```
- Font family (if identifiable)
- Heading sizes
- Body text size
- Small/caption text size
- Font weights used
```

### 5. Component Patterns

Identify UI patterns:
```
- Navigation style (tabs, sidebar, topbar)
- Card layout (shadow, border, padding)
- Button styles (filled, outline, ghost)
- Avatar style (circle, rounded square)
- Badge/tag style
- Input style
```

## Output Format

Generate a design tokens object:

```json
{
  "designTokens": {
    "colors": {
      "bg": {
        "primary": "#1a1a2e",
        "secondary": "#252542",
        "tertiary": "#16213e"
      },
      "text": {
        "primary": "#ffffff",
        "secondary": "#d1d5db",
        "muted": "#9ca3af"
      },
      "accent": {
        "primary": "#8b5cf6",
        "hover": "#7c3aed"
      },
      "status": {
        "success": "#10b981",
        "warning": "#f59e0b",
        "error": "#ef4444"
      },
      "border": {
        "default": "#374151",
        "focus": "#8b5cf6"
      }
    },
    "spacing": {
      "componentPadding": "1rem",
      "cardPadding": "1.5rem",
      "gap": "1rem",
      "sectionGap": "2rem"
    },
    "borderRadius": {
      "button": "0.5rem",
      "card": "0.75rem",
      "avatar": "9999px",
      "input": "0.5rem",
      "badge": "9999px"
    },
    "shadows": {
      "card": "0 4px 6px -1px rgba(0, 0, 0, 0.1)",
      "button": "0 2px 4px rgba(0, 0, 0, 0.1)"
    }
  },
  "components": {
    "navigation": {
      "style": "topbar with tabs",
      "height": "60px",
      "position": "sticky"
    },
    "cards": {
      "hasBorder": true,
      "hasShadow": false,
      "hoverEffect": "background lighten"
    },
    "buttons": {
      "primary": "gradient or solid fill",
      "secondary": "ghost/outline"
    }
  }
}
```

## Tailwind CSS Mapping

Convert tokens to Tailwind classes:

```
Colors → Custom colors in tailwind.config.js or inline [#hexcode]
Spacing → p-4, gap-4, m-6, etc.
Border Radius → rounded-md, rounded-lg, rounded-full
Shadows → shadow-md, shadow-lg
```

## Example Analysis

For a dark dashboard screenshot:

```
Observed:
- Dark purple/blue background
- Lighter purple cards
- Pink/red accent buttons
- White text with gray muted text
- Rounded corners on everything
- Subtle borders, no heavy shadows

Extracted:
{
  "colors": {
    "bg": {
      "primary": "#1a1a2e",
      "secondary": "#252542"
    },
    "accent": {
      "primary": "#e94560"
    },
    "text": {
      "primary": "#ffffff",
      "muted": "#9ca3af"
    }
  }
}
```

## Important Notes

1. **Be precise with colors** - Use a color picker mentally, estimate hex values
2. **Consider dark/light mode** - Note if design is dark or light theme
3. **Identify brand colors** - These are usually the accent colors
4. **Note hover states** - Usually slightly lighter/darker versions
5. **Check consistency** - Same colors should be used throughout
