# Activity Change OSD

A KWin script that briefly shows the name of the current activity in the
middle of the screen whenever you switch activities. It is the activity
counterpart of KWin's built-in Desktop Change OSD, which it is based on.

Requires Plasma 6.

## Install

```sh
git clone https://github.com/iankamin/activity-change-osd ~/.local/share/kwin/scripts/activitychangeosd
kwriteconfig6 --file kwinrc --group Plugins --key activitychangeosdEnabled true
qdbus6 org.kde.KWin /KWin reconfigure
```

It can also be enabled from System Settings > Window Management > KWin Scripts.

## Configuration

The popup stays up for 500 ms. To change it:

```sh
kwriteconfig6 --file kwinrc --group Script-activitychangeosd --key PopupHideDelay 1000
qdbus6 org.kde.KWin /KWin reconfigure
```

## License

GPL-2.0-or-later
