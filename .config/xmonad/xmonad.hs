import XMonad
import XMonad.Operations

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run


main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask    = mod4Mask      -- Rebind Mod to the Super key
    , layoutHook = myLayout      -- Use custom layouts
    , manageHook = myManageHook  -- Match on certain windows
    }
  `additionalKeysP`
    [ ("M-<Return>", spawn $ myTerminal ++ " -o font.size=" ++ myTermFontSize)
    , ("M-p", spawn myBrowser)
    , ("M-w", kill)
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 10%+")
    , ("<XF86AudioLowerVolume>", spawn "amixer set Master 10%-")
    , ("<XF86AudioMute>", spawn "amixer set Master toggle")
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl set 10%+")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 10%-")
    , ("<XF86AudioPlay>", spawn "brightnessctl --device='dell::kbd_backlight' set 1+")
    , ("XF86BrightnessAdjust", spawn "brightnessctl --device='dell::kbd_backlight' set 1-")
    ]

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog            --> doFloat
    ]

myLayout = tiled ||| Mirror tiled ||| Full  
  where
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

-- xmobar rendering
myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = red2 " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . red2 . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30
--xmobar colorscheme (dracula)
    blue, lowWhite, red2, red, white, yellow :: String -> String
    red2  = xmobarColor "#ff5555" "" --red dracula
    blue     = xmobarColor "#8be9fd" "" --cyan blue dracula
    white    = xmobarColor "#f8f8f2" "" --white dracula
    yellow   = xmobarColor "#50fa7b" "" --green dracula
    red      = xmobarColor "#ff5555" "" --red dracula
    lowWhite = xmobarColor "#f8f8f2" "" --white dracula

--options
myTerminal="alacritty"
myTermFontSize="16"
myBrowser="qutebrowser"
myEmail="neomutt"
