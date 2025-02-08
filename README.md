# sweet-dwl-dotfiles

A lightweight desktop experience for Arch-based GNU/Linux distributions made with a custom dwl configuration :) Comes with a installer too!

![screenshot_2024-11-17-155846](https://github.com/user-attachments/assets/64958040-6dcf-4c87-8339-34c918afab2f)

# This cofniguration contains:
## Patched and configured dwl wayland compositor
The dwl compositor is patched with:
- gaps
- autostart
- cursortheme

Configuration contains:
- Full function key configuration (shortcuts available in config.h)
- waybar and waypaper restore for autostart
- other tweaks and custom shortcuts
## Waybar and other important tools
- Configured waybar with many tools
- Rofi
- Waypaper wallpaper switcher (available through rofi and waybar)
- copyq clipboard manager (available through rofi and waybar)
- Network Manager Applet,
- Arch updates indicator and update button (waybar)
- Blue light filter switcher with gammastep (waybar)
- more

![screenshot_2024-11-17-155904](https://github.com/user-attachments/assets/da48d275-6645-458d-b36c-4c6d9dde4281)

![screenshot_2024-11-18-195406](https://github.com/user-attachments/assets/0ee19cde-31f7-4c69-90b0-fe83c6bee0e1)


## Installation

### Clone this repository using:
```
  git clone https://github.com/MikolajFrycz/sweet-dwl-dotfiles
```
### Open the cloned folder and make setup.sh executable:
```
  cd sweet-dwl-dotfiles
  sudo chmod +x setup.sh
```

### Run setup.sh as root:
```
  sudo ./setup.sh
```
### To choose your own wallpaper:
1. Open sweet-dwl folder
2. Edit config.h
3. Replace "pathToYourWallpaper" with a path to Your chosen image here:
```
static const char *const autostart[] = {
        "wbg", "pathToYourWallpaper", NULL,
```
