# Quiz Godot Project - Color Extraction Report

This document contains all colors extracted from the quiz Godot project files.

## Color Summary

### Primary Colors
- **Green (Primary)**: `Color(0.298039, 0.686275, 0.313726, 1)` - RGB(76, 175, 80) - Main brand color
- **Light Green**: `Color(0.705882, 0.917647, 0.803922, 1)` - RGB(180, 234, 205) - Progress bar background
- **Dark Green**: `Color(0, 0.729412, 0.337255, 1)` - RGB(0, 186, 86) - Progress bar active segments
- **Bright Green**: `Color(0.0901961, 0.882353, 0.45098, 1)` - RGB(23, 225, 115) - Answer button checked state

### Secondary Colors
- **Purple (Primary)**: `Color(0.45098, 0.0980392, 0.509804, 1)` - RGB(115, 25, 130) - Start screen buttons
- **Dark Purple**: `Color(0.25098, 0.0509804, 0.282353, 1)` - RGB(64, 13, 72) - Button pressed states
- **Pink/Red**: `Color(0.976471, 0.564706, 0.603922, 1)` - RGB(249, 144, 154) - Failed answer state

### Background Colors
- **Light Gray (Main)**: `Color(0.96, 0.96, 0.96, 1)` - RGB(245, 245, 245) - Main background
- **Light Gray (Quiz)**: `Color(0.95, 0.95, 0.95, 1)` - RGB(242, 242, 242) - Quiz background
- **Light Gray (Results)**: `Color(0.95, 0.95, 0.95, 1)` - RGB(242, 242, 242) - Results background
- **White**: `Color(1, 1, 1, 1)` - RGB(255, 255, 255) - Button backgrounds and text
- **Off-White**: `Color(0.933333, 0.92549, 0.933333, 1)` - RGB(238, 236, 238) - Disabled button background
- **Panel Background**: `Color(0.9, 0.95, 0.9, 1)` - RGB(230, 242, 230) - Results panel background
- **Info Panel**: `Color(0.980392, 0.980392, 0.980392, 1)` - RGB(250, 250, 250) - Information panel

### Text Colors
- **Dark Gray (Primary)**: `Color(0.2, 0.2, 0.2, 1)` - RGB(51, 51, 51) - Main text color
- **Medium Gray**: `Color(0.4, 0.4, 0.4, 1)` - RGB(102, 102, 102) - Secondary text
- **Dark Text**: `Color(0.262745, 0.231373, 0.278431, 1)` - RGB(67, 59, 71) - Button text
- **Disabled Text**: `Color(0.694118, 0.686275, 0.698039, 1)` - RGB(177, 175, 178) - Disabled button text
- **Black**: `Color(0, 0, 0, 1)` - RGB(0, 0, 0) - Timer and various text elements
- **Dark Red Text**: `Color(0.0980392, 0.0509804, 0.0509804, 1)` - RGB(25, 13, 13) - Info text
- **Orange Text**: `Color(0.8, 0.4, 0.2, 1)` - RGB(204, 102, 51) - Incorrect answers value
- **Gray Text**: `Color(0.392157, 0.384314, 0.384314, 1)` - RGB(100, 98, 98) - Panel text

### Border Colors
- **Green Border**: `Color(0.0901961, 0.882353, 0.45098, 1)` - RGB(23, 225, 115) - Answer button borders
- **Light Green Border**: `Color(0.501961, 0.858824, 0.67451, 1)` - RGB(128, 219, 172) - Disabled button borders

### Shadow Colors
- **Light Shadow**: `Color(0.501961, 0.482353, 0.482353, 0.254902)` - RGBA(128, 123, 123, 65) - Button shadows
- **Dark Shadow**: `Color(0, 0, 0, 0.2)` - RGBA(0, 0, 0, 51) - Checked button shadow
- **Black Shadow**: `Color(0, 0, 0, 0.388235)` - RGBA(0, 0, 0, 99) - Pressed button shadow
- **Panel Shadow**: `Color(0, 0, 0, 0.0431373)` - RGBA(0, 0, 0, 11) - Results panel shadow

### Disabled/Inactive Colors
- **Disabled Button**: `Color(0.847059, 0.843137, 0.85098, 1)` - RGB(216, 215, 217) - Next button disabled
- **Disabled Green**: `Color(0.501961, 0.858824, 0.67451, 1)` - RGB(128, 219, 172) - Disabled checked state
- **Disabled Text**: `Color(1, 1, 1, 0.5)` - RGBA(255, 255, 255, 128) - Disabled button text

## Color Usage by Component

### Answer Buttons
- **Normal State**: White background with green border
- **Checked State**: Bright green background and border
- **Disabled State**: Light gray background with light green border
- **Disabled Checked**: Light green background and border
- **Failed State**: Pink/red background and border

### Next Button
- **Normal**: Green background
- **Clicked**: Dark green background
- **Disabled**: Light gray background

### Progress Bar
- **Background**: Light green segments
- **Active**: Dark green segments

### Start Screen
- **Background**: Dark green
- **Buttons**: Purple with dark purple pressed state

### Text Elements
- **Titles**: Dark gray
- **Labels**: Medium gray
- **Values**: Green (for positive) or orange (for negative)

## Comments from Code
Found commented color references in [`main.gd`](app/godot/quiz/scripts/main.gd:105-107):
- Green progress: `Color(0.298039, 0.686275, 0.313726, 1)`
- Gray inactive: `Color(0.8, 0.8, 0.8, 1)`

## Files Analyzed
- Theme resource files (.tres): 11 files
- Scene files (.tscn): 7 files  
- Script files (.gd): 1 color reference found
- Color palette addon: Empty (no custom palettes found)

## Color Palette Recommendations
Based on the extracted colors, the quiz uses a cohesive color scheme with:
1. **Primary**: Green tones for positive actions and branding
2. **Secondary**: Purple tones for call-to-action elements
3. **Accent**: Pink/red for error states
4. **Neutral**: Various grays for backgrounds and text
5. **System**: White and black for contrast and readability