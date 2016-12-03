_TITLE "Alternative2000"

'$include:'.\THM\current.thm'

TYPE mousetype
    x AS INTEGER
    y AS INTEGER
    Lclick AS INTEGER
    Rclick AS INTEGER
    movement AS INTEGER
    icon AS STRING * 10
END TYPE

TYPE Display
    sizeX AS _UNSIGNED _INTEGER64
    sizeY AS _UNSIGNED _INTEGER64
    colorDepth AS _UNSIGNED INTEGER
END TYPE

TYPE MOUSEFLAGS
    OnWindow AS INTEGER '              current window pointer is hovering over
    Icon AS INTEGER '                  current mouse pointer icon
    X AS INTEGER '                     current desktop mouse x coordinate
    Y AS INTEGER '                     current desktop mouse y coordinate
    PX AS INTEGER '                    previous desktop mouse x coordinate
    PY AS INTEGER '                    previous desktop mouse y coordinate
    WindowX AS INTEGER '               current window mouse x coordinate
    WindowY AS INTEGER '               current window mouse y coordinate
    ScreenX AS INTEGER '               current work space mouse x coordinate
    ScreenY AS INTEGER '               current work space mouse y coordinate
    OnScreen AS INTEGER '       [BOOL] mouse currently hovering over work space?
    OnTitlebar AS INTEGER '     [BOOL] mouse currently hovering over title bar?
    OnBorder AS INTEGER '       [BOOL] mouse currently hovering over a border?
    Border AS INTEGER '                border(s) mouse hovering (1-top, 2-right, 4-bottom, 8-left ... i.e. 6 = bottom right corner)
    LeftClick AS INTEGER '      [BOOL] mouse left button currently pressed?
    RightClick AS INTEGER '     [BOOL] mouse right button currently pressed?
    Move AS INTEGER '                  window currently in the process of being moved
    Resize AS INTEGER '                current window being resized
    LeftReleased AS INTEGER '   [BOOL] left mouse button released?
    RightReleased AS INTEGER '  [BOOL] right mouse button released?
END TYPE

TYPE WINDOWFLAGS
    X AS INTEGER '                     x location of current window
    Y AS INTEGER '                     y location of current window
    Width AS INTEGER '                 width of current window
    Height AS INTEGER '                height of current window
    Screen AS LONG '            [IMG]  window work space image
    ScreenX AS INTEGER '               x location of current work space
    ScreenY AS INTEGER '               y location of current workspace
    ScreenWidth AS INTEGER '           width of current workspace
    ScreenHeight AS INTEGER '          height if current work space
    Focus AS INTEGER '                 the window that has focus
    HasFocus AS INTEGER '       [BOOL] current window has focus?
END TYPE

TYPE WIN
    Width AS INTEGER '                 overall window width
    Height AS INTEGER '                overall window height
    ScreenWidth AS INTEGER '           screen width
    ScreenHeight AS INTEGER '          screen height
    X AS INTEGER '                     window x location
    Y AS INTEGER '                     window y location
    ScreenX AS INTEGER '               workspace x location
    ScreenY AS INTEGER '               workspace y location
    BGX AS INTEGER '                   background image x location
    BGY AS INTEGER '                   background image y location
    Font AS LONG '              [FONT] window font
    InUse AS INTEGER '          [BOOL] window in use?
    Window AS LONG '            [IMG]  window image
    Screen AS LONG '            [IMG]  workspace image
    BGImage AS LONG '           [IMG]  background image under window
    TBFImage AS LONG '          [IMG]  title bar image when window has focus
    TBNFImage AS LONG '         [IMG]  title bar image when window has lost focus
    Shadow AS INTEGER '         [BOOL] shadow present
    BWidth AS INTEGER '                border width
    TBHeight AS INTEGER '              title bar height
    WColor AS _UNSIGNED LONG '  [CLR]  window color
    Wred AS INTEGER '           [CLR]  red component of Wcolor
    Wgreen AS INTEGER '         [CLR]  green component of Wcolor
    Wblue AS INTEGER '          [CLR]  blue component of Wcolor
    TBColor AS _UNSIGNED LONG ' [CLR]  title bar color
    TTColor AS _UNSIGNED LONG ' [CLR]  title text color
    Title AS STRING * 128 '            window title
    Visible AS INTEGER '        [BOOL] window on screen?
    Focus AS INTEGER '          [BOOL] window has focus?
    ByMethod AS INTEGER '       [BOOL] -1 = window dimensions by screen, 0 = dimensions by window
    Move AS INTEGER '           [BOOL] window currently being moved?
    Resize AS INTEGER '         [BOOL] window currently being resized
    Lighter AS _UNSIGNED LONG ' [CLR]  border colors
    Light AS _UNSIGNED LONG '   [CLR]
    Dark AS _UNSIGNED LONG '    [CLR]
    Darker AS _UNSIGNED LONG '  [CLR]
    Darkest AS _UNSIGNED LONG ' [CLR]
    Icon AS LONG '              [IMG]  window icon
    TBSolid AS INTEGER '        [BOOL] solid title bar?
    Size AS INTEGER '           [BOOL] window resizable?
    CloseButton AS INTEGER '           0 = no button, >0 = button handle number
    MaxButton AS INTEGER
    MinButton AS INTEGER
    RestoreButton AS INTEGER
    Maximized AS INTEGER '             -1 window currently maximized, 0 = normal  (use 'state' instead for max/min/normal?)
    Minimized AS INTEGER '             -1 window currently minimized
    Rwidth AS INTEGER '                restore width  (when max or min - values to restore window size)
    Rheight AS INTEGER '               restore height
END TYPE

TYPE BUTTON
    InUse AS INTEGER '          [BOOL] button in use?
    X AS INTEGER '                     x location of button
    Y AS INTEGER '                     y location of button
    Width AS INTEGER
    Height AS INTEGER
    State AS INTEGER '                 state of button: -1 = pressed, 0 = normal, 1 = disabled
    Normal AS LONG '            [IMG]  normal button
    Pressed AS LONG '           [IMG]  pressed button
    Disabled AS LONG '          [IMG]  disabled button
    Window AS INTEGER '                window button belongs to
    'Toolbar                           indicates a tool bar button only? (see note in BUT_PUT)
END TYPE

TYPE MOUSEPOINTERS
    Icon AS LONG '              [IMG]  mouse pointer image
    X AS INTEGER '                     x offset of pointer
    Y AS INTEGER '                     y offset of pointer
END TYPE

TYPE MenuType
    Caption AS STRING * 50
    Highlight AS _BYTE
    Inactive AS _BYTE
    Y AS SINGLE
END TYPE

CONST True = -1, False = NOT True

CONST CR = 13
CONST LF = 10

CONST BYWINDOW = 0
CONST BYSCREEN = -1

REDIM SHARED WIN(1) AS WIN
REDIM SHARED BUT(1) AS BUTTON
REDIM SHARED WinOrder%(0)
DIM SHARED POINTER(15) AS MOUSEPOINTERS
DIM SHARED QB64Icon&
DIM SHARED WIN AS WINDOWFLAGS
DIM SHARED MOUSE AS MOUSEFLAGS
DIM SHARED DeskTop&

DIM SHARED titlebarFont&
titlebarFont& = _LOADFONT("tahomabd.ttf", 11)

DIM SHARED demoWindow1
DIM SHARED demoWindow2
DIM SHARED demoWindow3
DIM SHARED demoWindow4

POINTERS

_MOUSEHIDE

customWindow
customWindow2

DIM SHARED primary AS Display
DIM SHARED secondary AS Display
'initializeWindowed
initializeFullscreen
DIM SHARED wallpaper AS STRING
LET wallpaper = ".\BMP\cloudswide.bmp"

DIM SHARED background$, build$, dd$

PRINT "Loading Alternative 2000..."
_DELAY 1
CLS

screenInfo

DIM buildo AS _UNSIGNED INTEGER
DIM buildt AS _UNSIGNED INTEGER
DIM buildk AS _UNSIGNED INTEGER

' Get current version number
OPEN ".\A95\build.bld" FOR INPUT AS #2
INPUT #2, buildo
INPUT #2, buildt
INPUT #2, buildk
CLOSE #2

' Update version number
OPEN ".\A95\build.bld" FOR OUTPUT AS #2

buildk = buildk + 1

IF buildk = 1000 THEN
    buildk = 0
    buildt = buildt + 1
END IF

IF buildt = 100 THEN
    buildo = buildo + 1
    buildt = 0
END IF

' Write new version number
PRINT #2, buildo
PRINT #2, buildt
PRINT #2, buildk
CLOSE #2

' Read new version number
OPEN ".\A95\build.bld" FOR INPUT AS #2
INPUT #2, buildo
INPUT #2, buildt
INPUT #2, buildk
CLOSE #2

' Store version number for future output
build$ = "Alternative 2000 Version " + LTRIM$(RTRIM$(STR$(buildo))) + "." + LTRIM$(RTRIM$(STR$(buildt))) + "." + LTRIM$(RTRIM$(STR$(buildk)))

splashScreen = _LOADIMAGE("splash.png")
_PUTIMAGE ((primary.sizeX - _WIDTH(splashScreen)) / 2, (primary.sizeY - _HEIGHT(splashScreen)) / 2), splashScreen

sdfont& = _LOADFONT("tahomabd.ttf", 12)

'$include: 'shutdownCheck.a95'

_DELAY 2

DIM SHARED startFont&, buildFont&, timeFont&
startFont& = _LOADFONT("tahomabd.ttf", 11)
buildFont& = _LOADFONT("tahoma.ttf", 10)
timeFont& = _LOADFONT("tahomabd.ttf", 11)

_FONT buildFont&
_PRINTMODE _KEEPBACKGROUND

DIM SHARED smb1&, umenu, redraw, cmlx, cmly
DIM SHARED winlogo&, timeloc&, startm&, startb&, startc&, startd&, taskbar&, sdhide&, background&
winlogo& = _LOADIMAGE("win.png")
startm& = _LOADIMAGE("start2000.png")
sdhide& = _LOADIMAGE("sd.png")
background& = _LOADIMAGE(wallpaper)

DIM SHARED startMenuPressed AS _BIT
LET startMenuPressed = 0

taskbar& = _NEWIMAGE(primary.sizeX, 28, 32)
createTaskbar

startb& = _NEWIMAGE(204, 281, 32)
createStartMenu

startc& = _NEWIMAGE(55, 22, 32)
startd& = _NEWIMAGE(55, 22, 32)
createStartButton

timeloc& = _NEWIMAGE(100, 22, 32)
createSystemTray

MenuSetup$ = "": MenuID$ = ""
MenuSetup$ = MenuSetup$ + "Fullscreen" + CHR$(LF): MenuID$ = MenuID$ + MKI$(15)
MenuSetup$ = MenuSetup$ + "Windowed" + CHR$(LF): MenuID$ = MenuID$ + MKI$(16)
MenuSetup$ = MenuSetup$ + "-" + CHR$(LF): MenuID$ = MenuID$ + MKI$(0)
MenuSetup$ = MenuSetup$ + "~Demo" + CHR$(LF): MenuID$ = MenuID$ + MKI$(17)
MenuSetup$ = MenuSetup$ + "-" + CHR$(LF): MenuID$ = MenuID$ + MKI$(0)
MenuSetup$ = MenuSetup$ + "Exit" + CHR$(LF): MenuID$ = MenuID$ + MKI$(18)

_DEST newscreen
redrawd
_DISPLAY

main:
DO
    IF _MOUSEINPUT THEN WIN_MOUSE
    WIN_UPDATE
    _DISPLAY
    mouseRefresh = _MOUSEINPUT
    mousex = _MOUSEX
    mousey = _MOUSEY
    mouseLeftButton = _MOUSEBUTTON(1)
    mouseRightButton = _MOUSEBUTTON(2)
    mouseMiddleButton = _MOUSEBUTTON(3)
    mouseWheel = mouseWheel + _MOUSEWHEEL
    currentMouseX = mousex
    currentMouseY = mousey
    IF mouseLeftButton = -1 THEN
        IF currentMouseX <= 58 AND currentMouseX >= 4 THEN
            IF currentMouseY <= primary.sizeY - 2 AND currentMouseY >= primary.sizeY - 22 THEN
                menu
            END IF
        END IF
    END IF

    IF mouseRightButton = -1 THEN
        _MOUSESHOW
        Choice = SHOWMENU(MenuSetup$, MenuID$, currentMouseX, currentMouseY)
        IF Choice = 18 THEN shutdown
        IF Choice = 16 THEN disableFullscreen
        IF Choice = 15 THEN enableFullscreen
        _MOUSEHIDE
    END IF
    redrawd
LOOP

SUB backPlace
_PUTIMAGE (0, 0)-(primary.sizeX, primary.sizeY), background&
END SUB

SUB menu
smx = 3
smy = primary.sizeY - 305
startopen = 1
_DEST newscreen
_PUTIMAGE (0, primary.sizeY - 28)-(primary.sizeX, primary.sizeY), taskbar&
_PUTIMAGE (3, primary.sizeY - 24), startd&
_PUTIMAGE (smx, smy), startb&
_MOUSESHOW
DO
    DO WHILE _MOUSEINPUT
        mousex = _MOUSEX
        mousey = _MOUSEY
        mouseLeftButton = _MOUSEBUTTON(1)
        mouseRightButton = _MOUSEBUTTON(2)
        mouseMiddleButton = _MOUSEBUTTON(3)
        mouseWheel = mouseWheel + _MOUSEWHEEL
    LOOP
    IF mouseLeftButton = -1 THEN
        IF mousex >= 23 AND mousex <= (primary.sizeX - primary.sizeX) + 169 THEN
            IF mousey >= primary.sizeY - 56 AND mousey <= (primary.sizeY - 56) + 28 THEN
                shutdown
            END IF
        END IF
        startopen = 0
    END IF
    time
    _DISPLAY
LOOP UNTIL startopen = 0
_MOUSEHIDE
redrawd
END SUB

SUB deskd
_DEST newscreen
_PUTIMAGE (0, primary.sizeY - 28)-(primary.sizeX, primary.sizeY), taskbar&
_PUTIMAGE (3, primary.sizeY - 24), startc&
_FONT buildFont&
COLOR whiteColor
_PRINTMODE _KEEPBACKGROUND
_PRINTSTRING (primary.sizeX - 150, primary.sizeY - 40), build$
END SUB

SUB time
_DEST newscreen
_PUTIMAGE (primary.sizeX - 102, primary.sizeY - 24), timeloc&
_FONT timeFont&
COLOR _RGB(0, 0, 0), _RGB(180, 180, 180)
_PRINTMODE _KEEPBACKGROUND
_PRINTSTRING (primary.sizeX - 53, primary.sizeY - 18), TIME$
END SUB

SUB shutdown
redrawd
_DELAY 1
_MOUSEHIDE
_PUTIMAGE (0, 0)-(primary.sizeX, primary.sizeY), sdhide&
_DISPLAY
OPEN "ss.ssc" FOR OUTPUT AS #3
PRINT #3, 1
CLOSE #3
_DELAY 3
SYSTEM
END SUB

SUB redrawd
backPlace
deskd
time
END SUB

SUB screenInfo
DIM height$, width$, colors$
width$ = STR$(primary.sizeX)
height$ = STR$(primary.sizeY)
colors$ = STR$(primary.colorDepth)
dd$ = LTRIM$(width$ + " x" + height$ + " at" + colors$ + "-bit color depth")
END SUB

SUB initializeFullscreen
primary.sizeX = _DESKTOPWIDTH
primary.sizeY = _DESKTOPHEIGHT
primary.colorDepth = 32
CALL initializeDisplay
_FULLSCREEN
END SUB

SUB initializeWindowed
primary.sizeX = 800
primary.sizeY = 600
primary.colorDepth = 32
CALL initializeDisplay
END SUB

SUB initializeDisplay
IF newscreen THEN
    _FREEIMAGE newscreen
END IF
newscreen = _NEWIMAGE(primary.sizeX, primary.sizeY, primary.colorDepth)
SCREEN newscreen
_PRINTMODE _KEEPBACKGROUND
END SUB

SUB enableFullscreen
initializeFullscreen
_FULLSCREEN
END SUB

SUB disableFullscreen
initializeWindowed
_FULLSCREEN _OFF
END SUB

SUB drawDesktop
IF wallpaperUsed = -1 THEN
    image& = _LOADIMAGE(wallpaper)
    _PUTIMAGE , image&
    _FREEIMAGE image&
ELSE
    LINE (0, 0)-(primary.sizeX - 1, primary.sizeY - 1), desktopColor, BF
END IF
END SUB

SUB clearScreen
CLS
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                         BUT_PUT
SUB BUT_PUT (b%, x%, y%, state%) ' state% needed?
'**
'** send in negative value for b% to indicate a tool bar button (better to add .toolbar flag instead?)
'** (negative values would only be used internally by library - still kind of confusing though ^^ see above ^^)
'**
DIM bx% ' button's x coordinate on tool bar
IF b% < 0 THEN '                                           toolbar button?
    b% = -b% '                                             yes, correct button handle
    bx% = WIN(BUT(b%).Window).Width - BUT(b%).X '          calculate button's x coordinate (BUT().x value is an offset)
    SELECT CASE BUT(b%).State '                            which state is tool bar button in?
        CASE -1 '                                          pressed
            _PUTIMAGE (bx%, BUT(b%).Y), BUT(b%).Pressed '  draw button
        CASE 0 '                                           normal (depressed)
            _PUTIMAGE (bx%, BUT(b%).Y), BUT(b%).Normal '   draw button
        CASE 1 '                                           disabled
            _PUTIMAGE (bx%, BUT(b%).Y), BUT(b%).Disabled ' draw button
    END SELECT
END IF
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                         BUT_NEW
FUNCTION BUT_NEW (win%, w%, h%, t$, f&, c~&, t~&)
'**
'** NEED TO REWORK                                                                                     TODO: fix tool bar buttons
'**                                                                                                          draw according to
'** Using _PUTIMAGE() to stretch tool bar buttons looks like poo!                                            TBHeight instead of
'**                                                                                                          stretching with
'** Buttons must be drawn according to the size of TBHeight                                                  _PUTIMAGE()
'**
DIM i% ' next available button array index
DIM c% ' generic counter
i% = UBOUND(BUT) '                                           get last button index
WHILE NOT BUT(i%).InUse AND i% > 1 '                         is button in use?
    REDIM _PRESERVE BUT(i% - 1) AS BUTTON '                  no, remove it
    i% = i% - 1 '                                            go to previous index
WEND
i% = 0 '                                                     start at beginning
c% = 1
DO '                                                         cycle through button indexes
    IF NOT BUT(c%).InUse THEN '                              button in use?
        i% = c% '                                            no, use this index
    ELSE '                                                   yes
        c% = c% + 1 '                                        increment index counter
        IF c% > UBOUND(BUT) THEN '                           reached end of buttons?
            REDIM _PRESERVE BUT(c%) AS BUTTON '              yes, create a new button
            i% = c% '                                        use this index
        END IF
    END IF
LOOP UNTIL i% '                                              leave when available index found
BUT(i%).InUse = -1 '                                         mark index as used
BUT(i%).Window = ABS(win%) '                                 button belongs to window (0 for desktop)
BUT(i%).State = 0 '                                          default to normal
BUT(i%).X = 0 '                                              reset x coordinate
BUT(i%).Y = 0 '                                              reset y coordinate
IF win% < 0 THEN '                                           creating a window button?
    win% = ABS(win%) '                                       yes, correct window owner
    BUT(i%).X = w% '                                         save toolbar button x location
    BUT(i%).Y = h% '                                         save toolbar button y location
    BUT(i%).State = 0 '                                      set button as normal (depressed)
    BUT(i%).Normal = _NEWIMAGE(16, 14, 32) '                 create normal image holder
    _DEST BUT(i%).Normal '                                   draw on image
    CLS , shadowColor '                                      create common button image
    LINE (0, 0)-(14, 12), highlightColor, B
    LINE (1, 1)-(14, 12), shadowColor, B
    LINE (1, 1)-(13, 11), faceColor, BF
    BUT(i%).Pressed = _NEWIMAGE(16, 14, 32) '                create pressed image holder
    _DEST BUT(i%).Pressed '                                  draw on image
    CLS , highlightColor '                                   create common button image
    LINE (0, 0)-(14, 12), shadowColor, B
    LINE (1, 1)-(14, 12), faceColor, B
    LINE (1, 1)-(13, 11), shadowColor, B
    LINE (2, 2)-(13, 11), faceColor, BF
    BUT(i%).Disabled = _NEWIMAGE(16, 14, 32) '               create disabled image holder
    _DEST BUT(i%).Disabled '                                 draw on image
    CLS , shadowColor '                                      create common button image
    LINE (0, 0)-(14, 12), highlightColor, B
    LINE (1, 1)-(14, 12), shadowColor, B
    LINE (1, 1)-(13, 11), faceColor, BF
    SELECT CASE t$ '                                         yes, which window button being created?
        CASE "CLOSE" '                                       close button
            _DEST BUT(i%).Normal '                           normal
            LINE (4, 3)-(10, 9), _RGB32(0, 0, 0)
            LINE (5, 3)-(11, 9), _RGB32(0, 0, 0)
            LINE (4, 9)-(10, 3), _RGB32(0, 0, 0)
            LINE (5, 9)-(11, 3), _RGB32(0, 0, 0)
            _DEST BUT(i%).Pressed '                          pressed
            LINE (5, 4)-(11, 10), _RGB32(0, 0, 0)
            LINE (6, 4)-(12, 10), _RGB32(0, 0, 0)
            LINE (5, 10)-(11, 4), _RGB32(0, 0, 0)
            LINE (6, 10)-(12, 4), _RGB32(0, 0, 0)
            _DEST BUT(i%).Disabled '                         disabled
            LINE (5, 10)-(11, 4), _RGB32(255, 255, 255)
            LINE (6, 10)-(12, 4), _RGB32(255, 255, 255)
            LINE (11, 10)-(12, 10), _RGB32(255, 255, 255)
            LINE (4, 3)-(10, 9), _RGB32(128, 128, 128)
            LINE (5, 3)-(11, 9), _RGB32(128, 128, 128)
            LINE (4, 9)-(10, 3), _RGB32(128, 128, 128)
            LINE (5, 9)-(11, 3), _RGB32(128, 128, 128)
        CASE "MAXIMIZE" '                                    maximize button
            _DEST BUT(i%).Normal '                           normal
            LINE (3, 3)-(11, 10), _RGB32(0, 0, 0), B
            LINE (3, 2)-(11, 2), _RGB32(0, 0, 0)
            _DEST BUT(i%).Pressed '                          pressed
            LINE (4, 4)-(12, 11), _RGB32(0, 0, 0), B
            LINE (4, 3)-(12, 3), _RGB32(0, 0, 0)
            _DEST BUT(i%).Disabled '                         disabled
            LINE (4, 4)-(12, 11), _RGB32(255, 255, 255), B
            PSET (12, 3), _RGB32(255, 255, 255)
            LINE (3, 3)-(11, 10), _RGB32(128, 128, 128), B
            LINE (3, 2)-(11, 2), _RGB32(128, 128, 128)
        CASE "MINIMIZE" '                                    minimize button
            _DEST BUT(i%).Normal '                           normal
            LINE (4, 9)-(9, 10), _RGB32(0, 0, 0), B
            _DEST BUT(i%).Pressed '                          pressed
            LINE (5, 10)-(10, 11), _RGB32(0, 0, 0), B
            _DEST BUT(i%).Disabled '                         disabled
            LINE (5, 10)-(10, 11), _RGB32(255, 255, 255), B
            LINE (4, 9)-(9, 10), _RGB32(128, 128, 128), B
        CASE "RESTORE" '                                     restore button
            _DEST BUT(i%).Normal '                           normal
            LINE (3, 6)-(8, 10), _RGB32(0, 0, 0), B
            LINE (3, 5)-(8, 5), _RGB32(0, 0, 0)
            PSET (5, 4), _RGB32(0, 0, 0)
            PSET (9, 7), _RGB32(0, 0, 0)
            LINE (5, 2)-(10, 3), _RGB32(0, 0, 0), B
            LINE (10, 4)-(10, 7), _RGB32(0, 0, 0)
            _DEST BUT(i%).Pressed '                          pressed
            LINE (4, 7)-(9, 11), _RGB32(0, 0, 0), B
            LINE (4, 6)-(9, 6), _RGB32(0, 0, 0)
            PSET (6, 5), _RGB32(0, 0, 0)
            PSET (10, 8), _RGB32(0, 0, 0)
            LINE (6, 3)-(11, 4), _RGB32(0, 0, 0), B
            LINE (11, 5)-(11, 8), _RGB32(0, 0, 0)
            _DEST BUT(i%).Disabled '                         disabled
            LINE (4, 7)-(9, 11), _RGB32(255, 255, 255), B
            LINE (6, 4)-(9, 4), _RGB32(255, 255, 255)
            LINE (10, 3)-(11, 8), _RGB32(255, 255, 255), B
            LINE (3, 6)-(8, 10), _RGB32(128, 128, 128), B
            LINE (3, 5)-(8, 5), _RGB32(128, 128, 128)
            PSET (5, 4), _RGB32(128, 128, 128)
            PSET (9, 7), _RGB32(128, 128, 128)
            LINE (5, 2)-(10, 3), _RGB32(128, 128, 128), B
            LINE (10, 4)-(10, 7), _RGB32(128, 128, 128)
    END SELECT
END IF
BUT_NEW = i%
END FUNCTION

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                       WIN_MOUSE
SUB WIN_MOUSE ()
'
' work in progress (only called when there has been mouse activity)
'
DIM c% ' current window being checked for mouse hover
DIM o% ' order of windows
DIM x% ' x offset movement of mouse
DIM y% ' y offset movement of mouse
MOUSE.PX = MOUSE.X '                                                                   save last mouse x position
MOUSE.PY = MOUSE.Y '                                                                   save last mouse y position
WHILE _MOUSEINPUT: WEND '                                                              get latest mouse status
MOUSE.X = _MOUSEX '                                                                    set desktop x coordinate flag
MOUSE.Y = _MOUSEY '                                                                    set desktop y coordinate flag
MOUSE.LeftClick = _MOUSEBUTTON(1) '                                                    set left mouse button status
MOUSE.RightClick = _MOUSEBUTTON(2) '                                                   set right mouse button status
IF NOT MOUSE.LeftClick THEN
    MOUSE.LeftReleased = -1 '                                                          left mouse button has been released?
    WIN(MOUSE.Move).Move = 0 '                                                         yes, window no longer being moved
    MOUSE.Move = 0 '                                                                   end window movement
    WIN(MOUSE.Resize).Resize = 0 '                                                     window no longer being resized
    MOUSE.Resize = 0 '                                                                 end window resizing
    MOUSE.Icon = 0 '                                                                   mouse pointer to default
ELSE
    IF MOUSE.Move THEN '                                                               window currently being moved?
        WIN_PUT MOUSE.move, WIN(MOUSE.move).X + MOUSEMOVEMENTX,_
                              WIN(MOUSE.move).Y + MOUSEMOVEMENTY,_
                              BYWINDOW '                                               yes, update window position
        MOUSE.Icon = 10 '                                                              change mouse pointer to move style
    ELSEIF MOUSE.Resize THEN '                                                         window currently being resized?
        x% = MOUSEMOVEMENTX '                                                          yes, get change in x position
        y% = MOUSEMOVEMENTY '                                                          get change in y position
        IF MOUSE.Border AND 1 THEN '                                                   mouse on top border?
            IF WIN(MOUSE.Resize).ScreenHeight - y% >= 10 THEN '                        yes, hit minimum size?
                WIN(MOUSE.Resize).Y = WIN(MOUSE.Resize).Y + y% '                       no, adjust window y location
                WIN(MOUSE.Resize).Height = WIN(MOUSE.Resize).Height - y% '             adjust overall window height
                '**
                '** adjusting screenheight/width here is going to become an issue when creating scrollbars
                '**
                '** need to work this into WIN_MAKE instead
                '**
                WIN(MOUSE.Resize).ScreenHeight = WIN(MOUSE.Resize).ScreenHeight - y% ' adjust work space height             ' this needed?
            ELSE '                                                                     yes, minimum reached
                _MOUSEMOVE MOUSE.X, MOUSE.PY '                                         force pointer back           (not working correctly in GL)
                MOUSE.Y = MOUSE.PY '                                                   update mouse y position
                MOUSE.PY = MOUSEMOVEMENTY '                                            seed new y offset position
            END IF
        ELSEIF MOUSE.Border AND 4 THEN '                                               no, mouse on bottom border?
            IF WIN(MOUSE.Resize).ScreenHeight + y% >= 10 THEN '                        yes, hit a minimum size?
                WIN(MOUSE.Resize).Height = WIN(MOUSE.Resize).Height + y% '             no, adjust overall window height
                WIN(MOUSE.Resize).ScreenHeight = WIN(MOUSE.Resize).ScreenHeight + y% ' adjust work space height
            ELSE '                                                                     yes, minimum reached
                _MOUSEMOVE MOUSE.X, MOUSE.PY '                                         force pointer back           (not working correclty in GL)
                MOUSE.Y = MOUSE.PY '                                                   update mouse y position
                MOUSE.PY = MOUSEMOVEMENTY '                                            seed new y offset position
            END IF
        END IF
        IF MOUSE.Border AND 2 THEN '                                                   mouse on right border?
            IF WIN(MOUSE.Resize).ScreenWidth + x% >= 10 THEN '                         yes, hit a minimum size?
                WIN(MOUSE.Resize).Width = WIN(MOUSE.Resize).Width + x% '               no, adjust overall window width
                WIN(MOUSE.Resize).ScreenWidth = WIN(MOUSE.Resize).ScreenWidth + x% '   adjust work space width
            ELSE '                                                                     yes, minimum reached
                _MOUSEMOVE MOUSE.PX, MOUSE.Y '                                         force pointer back           (not working correclty in GL)
                MOUSE.X = MOUSE.PX '                                                   update mouse x position
                MOUSE.PX = MOUSEMOVEMENTX '                                            seed new x offset position
            END IF
        ELSEIF MOUSE.Border AND 8 THEN '                                               no, mouse on left border?
            IF WIN(MOUSE.Resize).ScreenWidth - x% >= 10 THEN '                         yes, minimum size reached?
                WIN(MOUSE.Resize).X = WIN(MOUSE.Resize).X + x% '                       no, adjust window x location
                WIN(MOUSE.Resize).Width = WIN(MOUSE.Resize).Width - x% '               adjust overall window width
                WIN(MOUSE.Resize).ScreenWidth = WIN(MOUSE.Resize).ScreenWidth - x% '   adjust work space width
            ELSE '                                                                     yes, minimum reached
                _MOUSEMOVE MOUSE.PX, MOUSE.Y '                                         force pointer back           (not working correctly in GL)
                MOUSE.X = MOUSE.PX '                                                   update mouse x position
                MOUSE.PX = MOUSEMOVEMENTX '                                            seed new x offset position
            END IF
        END IF
        WIN_MAKE MOUSE.Resize '                                                        redraw window
    ELSE
        MOUSE.WindowX = MOUSE.X - WIN(MOUSE.OnWindow).X '                              set window x coordinate flag
        MOUSE.WindowY = MOUSE.Y - WIN(MOUSE.OnWindow).Y '                              set window y coordinate flag
        MOUSE.ScreenX = MOUSE.WindowX - WIN(MOUSE.OnWindow).ScreenX '                  yes, set work space x flag
        MOUSE.ScreenY = MOUSE.WindowY - WIN(MOUSE.OnWindow).ScreenY '                  set work space y flag
    END IF
END IF
IF NOT MOUSE.LeftReleased THEN EXIT SUB '                                              don't interact if left button being held down
WIN.X = 0 '                                                                            reset window flags
WIN.Y = 0
WIN.Width = 0
WIN.Height = 0
WIN.Screen = 0
WIN.ScreenX = 0
WIN.ScreenY = 0
WIN.ScreenWidth = 0
WIN.ScreenHeight = 0
WIN.HasFocus = 0
MOUSE.Icon = 0
MOUSE.OnWindow = 0 '                                                                   reset remaining mouse flags
MOUSE.WindowX = 0
MOUSE.WindowY = 0
MOUSE.OnScreen = 0
MOUSE.ScreenX = 0
MOUSE.ScreenY = 0
MOUSE.OnTitlebar = 0
MOUSE.OnBorder = 0
MOUSE.Border = 0
DO '                                                                                   loop through window order array
    c% = c% + 1 '                                                                      increment array index
    o% = WinOrder%(c%) '                                                               next window to check
    IF WIN(o%).Visible THEN '                                                          is window on screen?
        IF MOUSE.X >= WIN(o%).X THEN '                                                 yes, mouse within window coordinates?
            IF MOUSE.X <= WIN(o%).X + WIN(o%).Width - 1 THEN
                IF MOUSE.Y >= WIN(o%).Y THEN
                    IF MOUSE.Y <= WIN(o%).Y + WIN(o%).Height - 1 THEN
                        MOUSE.OnWindow = o% '                                          set pointer flag to hovered window
                        MOUSE.WindowX = MOUSE.X - WIN(o%).X '                          set window x coordinate flag
                        MOUSE.WindowY = MOUSE.Y - WIN(o%).Y '                          set window y coordinate flag
                        WIN.X = WIN(o%).X
                        WIN.Y = WIN(o%).Y
                        WIN.Width = WIN(o%).Width '                                    set window width flag
                        WIN.Height = WIN(o%).Height '                                  set window height flag
                        WIN.Screen = WIN(o%).Screen
                        WIN.ScreenX = WIN(o%).ScreenX
                        WIN.ScreenY = WIN(o%).ScreenY
                        WIN.ScreenWidth = WIN(o%).ScreenWidth '                        set window work space width flag
                        WIN.ScreenHeight = WIN(o%).ScreenHeight '                      set window work space height flag
                        WIN.HasFocus = WIN(o%).Focus
                        IF MOUSE.X >= WIN(o%).X + WIN(o%).ScreenX THEN '                                        mouse within work space?
                            IF MOUSE.X <= WIN(o%).X + WIN(o%).ScreenX + WIN(o%).ScreenWidth - 1 THEN
                                IF MOUSE.Y >= WIN(o%).Y + WIN(o%).ScreenY THEN
                                    IF MOUSE.Y <= WIN(o%).Y + WIN(o%).ScreenY + WIN(o%).ScreenHeight - 1 THEN '
                                        MOUSE.ScreenX = MOUSE.WindowX - WIN(o%).ScreenX '                       yes, set work space x flag
                                        MOUSE.ScreenY = MOUSE.WindowY - WIN(o%).ScreenY '                       set work space y flag
                                        MOUSE.OnScreen = -1 '                                                   set work space flag
                                    END IF
                                ELSE '                                                                          no
                                    IF MOUSE.Y >= WIN(o%).Y + WIN(o%).BWidth THEN '                             mouse within title bar?
                                        IF MOUSE.Y <= WIN(o%).Y + WIN(o%).BWidth + WIN(o%).TBHeight - 1 THEN
                                            MOUSE.OnTitlebar = -1 '                                             yes, set title bar flag
                                        END IF
                                    END IF
                                END IF
                            END IF
                        END IF
                        IF WIN(o%).Size THEN '                                                               is window resizable?
                            IF NOT MOUSE.OnScreen THEN '                                                     yes, mouse on work space?
                                IF NOT MOUSE.OnTitlebar THEN '                                               no, mouse on title bar?
                                    MOUSE.OnBorder = -1 '                                                    no, mouse is on a border
                                    IF MOUSE.Y <= WIN(o%).Y + WIN(o%).BWidth - 1 THEN '                      on top border?
                                        MOUSE.Border = 1 '                                                   yes, set border value
                                    ELSEIF MOUSE.Y >= WIN(o%).Y + WIN(o%).Height - WIN(o%).BWidth - 1 THEN ' no, on bottom border?
                                        MOUSE.Border = MOUSE.Border + 4 '                                    yes, add border value
                                    END IF
                                    IF MOUSE.X >= WIN(o%).X + WIN(o%).Width - WIN(o%).BWidth - 1 THEN '      on right border?
                                        MOUSE.Border = MOUSE.Border + 2 '                                    yes, add border value
                                    ELSEIF MOUSE.X <= WIN(o%).X + WIN(o%).BWidth - 1 THEN '                  no, on left border?
                                        MOUSE.Border = MOUSE.Border + 8 '                                    yes, add border value
                                    END IF
                                    MOUSE.Icon = MOUSE.Border '                                              mouse icon to resize
                                END IF
                            END IF
                        END IF
                    END IF
                END IF
            END IF
        END IF
    END IF
LOOP UNTIL MOUSE.OnWindow OR c% = UBOUND(WinOrder%) '                   leave when hovering or entire array scanned
IF MOUSE.LeftClick THEN MOUSE.LeftReleased = 0 '                        left mouse button currently held down
IF MOUSE.OnWindow AND MOUSE.LeftClick THEN '                            is pointer on a window and left button pressed?
    WIN_SETFOCUS MOUSE.OnWindow '                                       yes, this window now has focus
    c% = MOUSEMOVEMENTX '                                               seed mouse x offset function
    c% = MOUSEMOVEMENTY '                                               seed mouse y offset function
    IF MOUSE.OnTitlebar AND MOUSE.Move = 0 THEN '                       is pointer on title bar and window not moving?
        MOUSE.Move = MOUSE.OnWindow '                                   yes, this window can now be moved
        WIN(MOUSE.Move).Move = -1 '                                     set window state to moving
    ELSEIF MOUSE.OnBorder AND MOUSE.Resize = 0 THEN '                   is mouse on border and not resizing?
        MOUSE.Resize = MOUSE.OnWindow '                                 yes, this window can now be resized
        WIN(MOUSE.Resize).Resize = -1 '                                 set window state to resizing
    END IF
END IF
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                    WIN_SETFOCUS
SUB WIN_SETFOCUS (h%)
'
' h% = handle of window to set focus
'
DIM c%, o%
DIM Odest&
Odest& = _DEST
IF h% < 1 THEN EXIT SUB '                                         leave if no window selected
IF WIN(h%).Focus THEN EXIT SUB '                                  leave if window already in focus
IF NOT WIN(h%).Visible THEN EXIT SUB '                            leave if window is not on screen
DO '                                                              loop through window order array
    c% = c% + 1 '                                                 increment array index
LOOP UNTIL h% = WinOrder%(c%) OR c% = UBOUND(WinOrder%) '         leave if window found or end of array reached
IF c% = UBOUND(WinOrder%) AND WinOrder%(c%) <> h% THEN EXIT SUB ' window does not exist, leave subroutine
FOR o% = c% - 1 TO 1 STEP -1 '                                    cycle through array
    WinOrder%(o% + 1) = WinOrder%(o%) '                           move windows above h% down one
NEXT o%
WinOrder%(1) = h% '                                               make this window the new focus
WIN(h%).Focus = -1 '                                              this window now has focus
_DEST WIN(h%).Window
_PUTIMAGE (WIN(h%).BWidth, WIN(h%).BWidth), WIN(h%).TBFImage
IF UBOUND(winorder%) > 1 THEN
    WIN(WinOrder%(2)).Focus = 0 '                                     previous window lost focus
    _DEST WIN(WinOrder%(2)).Window
    _PUTIMAGE (WIN(WinOrder%(2)).BWidth, WIN(WinOrder%(2)).BWidth), WIN(WinOrder%(2)).TBNFImage
    _DEST Odest&
END IF
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                      WIN_UPDATE
SUB WIN_UPDATE ()
DIM o%
DIM h%
IF DeskTop& THEN _PUTIMAGE (0, 0), DeskTop&
FOR o% = UBOUND(WinOrder%) TO 1 STEP -1
    h% = WinOrder%(o%)
    IF WIN(h%).Visible THEN
        _PUTIMAGE (WIN(h%).ScreenX, WIN(h%).ScreenY), WIN(h%).Screen, WIN(h%).Window
        _PUTIMAGE (WIN(h%).X, WIN(h%).Y), WIN(h%).Window
    END IF
NEXT o%
_PUTIMAGE (MOUSE.X + POINTER(MOUSE.Icon).X, MOUSE.Y + POINTER(MOUSE.Icon).Y), POINTER(MOUSE.Icon).Icon
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                         WIN_PUT
SUB WIN_PUT (h%, x%, y%, m%)
'
' h% - handle of window to move
' x% - new window x coordinate
' y% - new window y coordinate
' m% - method of move (by work space origin coordinates (BYSCREEN) or by entire window origin coordinates (BYWINDOW))
'
IF m% THEN '                                                BYSCREEN
    WIN(h%).X = x% - WIN(h%).BWidth
    WIN(h%).Y = y% - WIN(h%).BWidth - WIN(h%).TBHeight
    WIN(h%).BGX = WIN(h%).X
    WIN(h%).BGY = WIN(h%).Y
ELSE '                                                      BYWINDOW
    WIN(h%).X = x%
    WIN(h%).Y = y%
    WIN(h%).BGX = x%
    WIN(h%).BGY = y%
END IF
IF WIN(h%).Visible THEN WIN_SETFOCUS h%
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                        WIN_MAKE
SUB WIN_MAKE (h%)
'
' h% - handle of window to create
'
DIM c% '                  generic counter
DIM Red!, Green!, Blue!
DIM Redinc!, Greeninc!, Blueinc!
DIM CurrentDest&
DIM Temp&
DIM x%, y%
CurrentDest& = _DEST '                                                                      remember calling destination
IF WIN(h%).Resize THEN '                                                                    window being resized?
    Temp& = _COPYIMAGE(WIN(h%).Screen) '                                                    yes, save a copy of screen
    _FREEIMAGE WIN(h%).Window '                                                             remove window image from RAM
    _FREEIMAGE WIN(h%).Screen '                                                             remove screen image from RAM
    IF (MOUSE.Border AND 2) OR (MOUSE.Border AND 8) THEN '                                  resizing right or left border?
        _FREEIMAGE WIN(h%).TBFImage '                                                       yes, remove title bar focus image
        _FREEIMAGE WIN(h%).TBNFImage '                                                      remove title bar no focus image
    END IF
ELSE
    WIN(h%).TBHeight = 18 '                                                                 calculate title bar height
    IF WIN(h%).ByMethod THEN '                                                              draw by screen?
        WIN(h%).Width = WIN(h%).ScreenWidth + WIN(h%).BWidth * 2 + 1 '                      yes, calculate window width
        WIN(h%).Height = WIN(h%).ScreenHeight + WIN(h%).BWidth * 2 + WIN(h%).TBHeight + 1 ' calculate window height
    ELSE '                                                                                  no, draw by window
        WIN(h%).ScreenWidth = WIN(h%).Width - WIN(h%).BWidth * 2 '                          calculate window width
        WIN(h%).ScreenHeight = WIN(h%).Height - WIN(h%).BWidth * 2 - WIN(h%).TBHeight '     calculate window height
    END IF
    WIN(h%).ScreenX = WIN(h%).BWidth '                                                      calculate screen x location
    WIN(h%).ScreenY = WIN(h%).BWidth + WIN(h%).TBHeight '                                   calculate screen y location
    CALCULATECOLORS h% '                                                                    calculate window color shades
    x% = WIN(h%).TBHeight + WIN(h%).BWidth + 2 '                                            calculate button offset coordinates
    y% = 2
    WIN(h%).CloseButton = BUT_NEW(-h%, x% + 1, y%, "CLOSE", 0, 0, 0) '                      create toolbar buttons
    WIN(h%).MaxButton = BUT_NEW(-h%, x% + 19, y%, "MAXIMIZE", 0, 0, 0)
    WIN(h%).MinButton = BUT_NEW(-h%, x% + 35, y%, "MINIMIZE", 0, 0, 0)
    WIN(h%).RestoreButton = BUT_NEW(-h%, x% + 19, y%, "RESTORE", 0, 0, 0)
    WIN(h%).TBFImage = _NEWIMAGE(WIN(h%).ScreenWidth, WIN(h%).TBHeight, 32) '               create title bar with focus
    WIN(h%).TBNFImage = _NEWIMAGE(WIN(h%).ScreenWidth, WIN(h%).TBHeight, 32) '              create title bar without focus
END IF
WIN(h%).Window = _NEWIMAGE(WIN(h%).Width, WIN(h%).Height, 32) '                             create window image container
WIN(h%).Screen = _NEWIMAGE(WIN(h%).ScreenWidth, WIN(h%).ScreenHeight, 32) '                 create screen image container
IF NOT (WIN(h%).Resize AND ((MOUSE.Border = 1) OR (MOUSE.Border = 4))) THEN '               resizing right or left border?
    WIN(h%).TBFImage = _NEWIMAGE(WIN(h%).ScreenWidth, WIN(h%).TBHeight, 32) '               yes, create title bar with focus
    WIN(h%).TBNFImage = _NEWIMAGE(WIN(h%).ScreenWidth, WIN(h%).TBHeight, 32) '              create title bar without focus
    '**
    '** need to create a function/sub that creates the tool bar images
    '**
    '** code below is repeated twice
    '**
    _DEST WIN(h%).TBFImage '                                                                draw on title bar focus image
    IF WIN(h%).TBSolid THEN '                                                               title bar solid color?         (fast)
        CLS , activeTitlebarColor '                                                         yes, color title bar
    ELSE '                                                                                  no, title bar faded coloring   (slow)
        Red! = _RED(WIN(h%).TBColor) '                                                      get title bar color components
        Green! = _GREEN(WIN(h%).TBColor)
        Blue! = _BLUE(WIN(h%).TBColor)
        Redinc! = (255 - Red!) / WIN(h%).ScreenWidth / 2 '                                  calculate color fade values
        Greeninc! = (255 - Green!) / WIN(h%).ScreenWidth / 2
        Blueinc! = (255 - Blue!) / WIN(h%).ScreenWidth / 2
        FOR c% = 0 TO WIN(h%).ScreenWidth - 1 '                                             cycle through width of title bar
            LINE (c%, 0)-(c%, WIN(h%).TBHeight - 1), _RGB32(Red!, Green!, Blue!) '          draw current color bar
            Red! = Red! + Redinc! '                                                         add fade values to colors
            Green! = Green! + Greeninc!
            Blue! = Blue! + Blueinc!
        NEXT c%
    END IF
    _FONT WIN(h%).Font '                                                                    set title bar font
    _PRINTMODE _KEEPBACKGROUND '                                                            font will be transparent
    COLOR WIN(h%).TTColor '                                                                 set font color
    _PRINTSTRING (WIN(h%).TBHeight + 2, 4), RTRIM$(WIN(h%).Title) '                         print title on title bar
    _PUTIMAGE (2, 2)-(WIN(h%).TBHeight - 2, WIN(h%).TBHeight - 2), WIN(h%).Icon '           place icon on title bar
    IF WIN(h%).CloseButton THEN BUT_PUT -WIN(h%).CloseButton, 0, 0, 0
    IF WIN(h%).MaxButton THEN BUT_PUT -WIN(h%).MaxButton, 0, 0, 0
    IF WIN(h%).MinButton THEN BUT_PUT -WIN(h%).MinButton, 0, 0, 0
    _DEST WIN(h%).TBNFImage
    IF WIN(h%).TBSolid THEN
        CLS , inactiveTitlebarColor
    ELSE
        Red! = 128
        Green! = 128
        Blue! = 128
        Redinc! = 63 / WIN(h%).ScreenWidth
        Greeninc! = 63 / WIN(h%).ScreenWidth
        Blueinc! = 63 / WIN(h%).ScreenWidth
        FOR c% = 0 TO WIN(h%).ScreenWidth - 1
            LINE (c%, 0)-(c%, WIN(h%).TBHeight - 1), _RGB32(Red!, Green!, Blue!)
            Red! = Red! + Redinc!
            Green! = Green! + Greeninc!
            Blue! = Blue! + Blueinc!
        NEXT c%
    END IF
    _FONT WIN(h%).Font
    _PRINTMODE _KEEPBACKGROUND
    COLOR _RGB32(212, 208, 200)
    _PRINTSTRING (WIN(h%).TBHeight + 2, 4), RTRIM$(WIN(h%).Title)
    _PUTIMAGE (2, 2)-(WIN(h%).TBHeight - 2, WIN(h%).TBHeight - 2), WIN(h%).Icon
    IF WIN(h%).CloseButton THEN BUT_PUT -WIN(h%).CloseButton, 0, 0, 0
    IF WIN(h%).MaxButton THEN BUT_PUT -WIN(h%).MaxButton, 0, 0, 0
    IF WIN(h%).MinButton THEN BUT_PUT -WIN(h%).MinButton, 0, 0, 0
END IF
_DEST WIN(h%).Screen
CLS , faceColor
IF WIN(h%).Resize THEN
    _PUTIMAGE (0, 0), Temp&
    _FREEIMAGE Temp&
END IF
_DEST WIN(h%).Window
CLS , WIN(h%).WColor '                                                                   clear window image
IF WIN(h%).BWidth THEN '                                                                 draw a border?
    LINE (0, 0)-(WIN(h%).Width - 1, WIN(h%).Height - 1), shadowColor, B '                yes, draw bottom and right border
    LINE (0, 0)-(WIN(h%).Width - 2, WIN(h%).Height - 2), faceColor, B '                  draw top and left border
    LINE (1, 1)-(WIN(h%).Width - 2, WIN(h%).Height - 2), shadowColor, B '                draw bottom and right middle border
    LINE (1, 1)-(WIN(h%).Width - 3, WIN(h%).Height - 3), whiteColor, B '                 draw top and left middle border
    LINE (2, 2)-(WIN(h%).Width - 3, WIN(h%).Height - 3), faceColor, B
END IF
IF WIN(h%).Focus THEN
    _PUTIMAGE (WIN(h%).BWidth, WIN(h%).BWidth), WIN(h%).TBFImage
ELSE
    _PUTIMAGE (WIN(h%).BWidth, WIN(h%).BWidth), WIN(h%).TBNFImage
END IF
_DEST CurrentDest&
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                         WIN_NEW
FUNCTION WIN_NEW (w%, h%, m%)
'
' w% = width of window workspace
' h% = height of window workspace
'
' returns = integer handle number to reference specified window
'
DIM i% ' next available window array index
DIM c% ' generic counter
i% = UBOUND(WIN) '                                 get last window index
WHILE NOT WIN(i%).InUse AND i% > 1 '               is window in use?
    REDIM _PRESERVE WIN(i% - 1) AS WIN '           no, remove it
    i% = i% - 1 '                                  go to previous index
WEND
i% = 0 '                                           start at beginning
c% = 1
DO '                                               cycle through window indexes
    IF NOT WIN(c%).InUse THEN '                    window is use?
        i% = c% '                                  no, use this index
    ELSE '                                         yes
        c% = c% + 1 '                              increment index counter
        IF c% > UBOUND(WIN) THEN '                 reached end of windows?
            REDIM _PRESERVE WIN(c%) AS WIN '       yes, create a new window
            i% = c% '                              use this index
        END IF
    END IF
LOOP UNTIL i% '                                    leave when available index found
WIN(i%).InUse = -1 '                               mark index as used
WIN(i%).Visible = 0 '                              set window invisible
WIN(i%).ByMethod = m%
IF m% THEN
    WIN(i%).ScreenWidth = w% '                     set workspace width
    WIN(i%).ScreenHeight = h% '                    set workspace height
ELSE
    WIN(i%).Width = w%
    WIN(i%).Height = h%
END IF
WIN(i%).X = 0 '                                    set window x location
WIN(i%).Y = 0 '                                    set window y location
WIN(i%).BWidth = 3 '                               set border width
WIN(i%).Font = _FONT
WIN(i%).Title = ""
WIN(i%).Icon = QB64Icon&
WIN(i%).WColor = _RGB32(192, 192, 192) '           set window color
WIN(i%).TBColor = _RGB32(10, 40, 100) '            set title bar color
WIN(i%).TTColor = _RGB32(255, 255, 255) '          set title bar text color
WIN(i%).TBSolid = -1
WIN(i%).Shadow = 0 '                               set window shadow (off)
WIN(i%).Focus = 0 '                                set window without focus
WIN(i%).Move = 0
WIN(i%).Resize = 0
WIN(i%).Size = 0
WIN(i%).CloseButton = 0
WIN(i%).MaxButton = 0
WIN(i%).MinButton = 0
WIN(i%).RestoreButton = 0
WIN(i%).Maximized = 0
WIN(i%).Minimized = 0
REDIM _PRESERVE WinOrder%(UBOUND(WinOrder%) + 1) ' increase window order array
WinOrder%(UBOUND(WinOrder%)) = i% '                add window to order array
WIN_NEW = i% '                                     return window handle
END FUNCTION

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                    WIN_SETTITLE
SUB WIN_SETTITLE (h%, t$)
WIN(h%).Title = t$ ' set title of window
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                     WIN_SETFONT
SUB WIN_SETFONT (h%, f&)
WIN(h%).Font = f& ' set window font
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                   WIN_SETBORDER
SUB WIN_SETBORDER (h%, w%)
WIN(h%).BWidth = w%
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                    WIN_SETCOLOR
SUB WIN_SETCOLOR (h%, c~&)
WIN(h%).WColor = c~& ' set window color
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                            WIN_SETTITLEBARCOLOR
SUB WIN_SETTITLEBARCOLOR (h%, c~&)
WIN(h%).TBColor = c~& ' set title bar color
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                        WIN_SHOW
SUB WIN_SHOW (h%)
WIN(h%).Visible = -1
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                        WIN_HIDE
SUB WIN_HIDE (h%)
WIN(h%).Visible = 0
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                          POINTERS
SUB POINTERS ()
DIM Icon$
Icon$ = "b           bb          bwb         bwwb        bwwwb       bwwwwb      bwwwwwb     bwwwwwwb    "+_
        "bwwwwwwwb   bwwwwwwwwb  bwwwwwwwwwb bwwwwwwbbbbbbwwwbwwb    bwwbbwwb    bwb  bwwb   bb   bwwb   "+_
        "b     bwwb        bwwb         bwwb        bwwb         bb  "
MAKEICON 0, Icon$, 12, 21, 0, 0 ' default - 12x21 - offset 0,0
Icon$ = "    w       wbw     wbbbw   wbbbbbw wbbbbbbbwwwwwbwwww   wbw      wbw      wbw      wbw   "+_
        "   wbw      wbw      wbw      wbw      wbw   wwwwbwwwwwbbbbbbbw wbbbbbw   wbbbw     wbw       w    "
MAKEICON 1, Icon$, 9, 21, -4, -10 ' NS resize - 9x21 - offset 5,11
Icon$ = "    ww         ww       wbw         wbw     wbbw         wbbw   wbbbwwwwwwwwwwwbbbw wbbbbbbbbbbbbbbbbbbbw"+_
        " wbbbwwwwwwwwwwwbbbw   wbbw         wbbw     wbw         wbw       ww         ww    "
MAKEICON 2, Icon$, 21, 9, -10, -4 ' EW resize - 21x9 - offset 11,5
Icon$ = "        wwwwwww        wbbbbbw         wbbbbw          wbbbw         wbwbbw        wbw wbw"+_
        "       wbw   ww      wbw      ww   wbw       wbw wbw        wbbwbw         wbbbw          "+_
        "wbbbbw         wbbbbbw        wwwwwww        "
MAKEICON 3, Icon$, 15, 15, -7, -7 ' NESW resize - 15x15 - offset 8,8
Icon$ = "     bb              bwwb             bwwb             bwwb             bwwb             bwwbbb       "+_
        "    bwwbwwbbb        bwwbwwbwwbb      bwwbwwbwwbwb bbb bwwbwwbwwbwwbbwwbbwwwwwwwwbwwbbwwwbwwwwwwwwwwwb"+_
        " bwwbwwwwwwwwwwwb  bwbwwwwwwwwwwwb  bwwwwwwwwwwwwwb   bwwwwwwwwwwwwb   bwwwwwwwwwwwb     bwwwwwwwwwwb "+_
        "    bwwwwwwwwwwb      bwwwwwwwwb       bwwwwwwwwb       bbbbbbbbbb  "
MAKEICON 5, Icon$, 17, 22, -5, 0 ' pointer (hand) - 17x22 - offset 6,0
Icon$ = "wwwwwww        wbbbbbw        wbbbbw         wbbbw          wbbwbw         wbw wbw        "+_
        "ww   wbw             wbw             wbw   ww        wbw wbw         wbwbbw          wbbbw"+_
        "         wbbbbw        wbbbbbw        wwwwwww"
MAKEICON 6, Icon$, 15, 15, -7, -7 ' NWSE resize - 15x15 - offset 8,8
Icon$ = "bbbbbbbbbbbbbbbwwwwwwwwwbbbbbbbbbbbbbbb bwwwwwwwwwb  bwwwwwwwwwb  bwwbwbwbwwb  bwwwbwbwwwb "+_
        " bbwwwbwwwbb   bbwwwwwbb     bbwbwbb       bbwbb        bbwbb       bbwwwbb     bbwwbwwbb  "+_
        " bbwwwwwwwbb  bwwwwbwwwwb  bwwwbwbwwwb  bwwbwbwbwwb  bwbwbwbwbwb bbbbbbbbbbbbbbbwwwwwwwwwbbbbbbbbbbbbbbb"
MAKEICON 7, Icon$, 13, 22, -6, -10 ' wait - 13x22 - offset 7,11
Icon$ = "          w                   wbw                 wbbbw               wbbbbbw             wbbbbbbbw      "+_
        "      wwwwbwwww          ww   wbw   ww       wbw   wbw   wbw     wbbw   wbw   wbbw   wbbbwwwwwbwwwwwbbbw "+_
        "wbbbbbbbbbbbbbbbbbbbw wbbbwwwwwbwwwwwbbbw   wbbw   wbw   wbbw     wbw   wbw   wbw       ww   wbw   ww    "+_
        "      wwwwbwwww            wbbbbbbbw             wbbbbbw               wbbbw                 wbw         "+_
        "          w          "
MAKEICON 10, Icon$, 21, 21, -10, -10 ' move - 21x21 - offset 11,11
Icon$ = "        www                wbw                wbw                wbw                wbw        "+_
        "        wbw                wbw                wbw        wwwwwwwwwbwwwwwwwwwwbbbbbbbbbbbbbbbbbw"+_
        "wwwwwwwwwbwwwwwwwww        wbw                wbw                wbw                wbw        "+_
        "        wbw                wbw                wbw                www        "
MAKEICON 11, Icon$, 19, 19, -9, -9 ' crosshair - 19x19 - offset 10,10
Icon$ = "wwww wwwwwbbbwbbbwwwwwbwwww   wbw      wbw      wbw      wbw      wbw      wbw      wbw   "+_
        "   wbw      wbw      wbw      wbw      wbw   wwwwbwwwwwbbbwbbbwwwww wwww"
MAKEICON 13, Icon$, 9, 18, -4, -8 ' text - 9x18 - offset 5,9
Icon$ = "       wwwwww            wwbbbbbbww         wbbbbbbbbbbw       wbbbbwwwwbbbbw     wbbbww    wwbbbw  "+_
        " wbbbbbw      wbbbw  wbbwbbbw      wbbw wbbbwwbbbw     wbbbwwbbw  wbbbw     wbbwwbbw   wbbbw    wbbw"+_
        "wbbw    wbbbw   wbbwwbbw     wbbbw  wbbwwbbbw     wbbbwwbbbw wbbw      wbbbwbbw  wbbbw      wbbbbbw "+_
        "  wbbbww    wwbbbw     wbbbbwwwwbbbbw       wbbbbbbbbbbw         wwbbbbbbww            wwwwww       "
MAKEICON 14, Icon$, 20, 20, -9, -9 ' not-allowed - 20x20 - offset 10,10
Icon$ = "11111111111111111111121133333331144444444112113355533114455554411211335553311445555441121133555331144444441112"+_
        "11335553311444444411121133555331144555544112113355533114455554411211333333311444444441121133333331144444444112"+_
        "11113331111111111111121111111111111111111112116666666117711117711211661111111771111771121166111111177111177112"+_
        "11666666611777777771121166666661177777777112116655566111111117711211665556611111111771121166666661111111177112"+_
        "11111111111111111111122222222222222222222222"
MAKEICON -1, Icon$, 22, 22, 0, 0 ' QB64 - 22x22
POINTER(4) = POINTER(1)
POINTER(8) = POINTER(2)
POINTER(9) = POINTER(6)
POINTER(12) = POINTER(3)
END SUB


'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                        MAKEICON
SUB MAKEICON (n%, i$, w%, h%, xo%, yo%)
DIM x%
DIM y%
DIM p$
DIM c%
IF n% = -1 THEN
    QB64Icon& = _NEWIMAGE(22, 22, 32)
    _DEST QB64Icon&
ELSE
    POINTER(n%).Icon = _NEWIMAGE(w%, h%, 32)
    POINTER(n%).X = xo%
    POINTER(n%).Y = yo%
    _DEST POINTER(n%).Icon
END IF
FOR y% = 0 TO h% - 1
    FOR x% = 0 TO w% - 1
        c% = c% + 1
        p$ = MID$(i$, c%, 1)
        IF p$ = "b" THEN PSET (x%, y%), _RGB32(0, 0, 1)
        IF p$ = "w" THEN PSET (x%, y%), _RGB32(255, 255, 255)
        IF p$ = "1" THEN PSET (x%, y%), _RGB32(0, 0, 252)
        IF p$ = "2" THEN PSET (x%, y%), _RGB32(0, 0, 112)
        IF p$ = "3" THEN PSET (x%, y%), _RGB32(0, 188, 252)
        IF p$ = "4" THEN PSET (x%, y%), _RGB32(0, 124, 252)
        IF p$ = "5" THEN PSET (x%, y%), _RGB32(0, 0, 168)
        IF p$ = "6" THEN PSET (x%, y%), _RGB32(252, 188, 0)
        IF p$ = "7" THEN PSET (x%, y%), _RGB32(252, 124, 0)
    NEXT x%
NEXT y%
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                 CALCULATECOLORS
SUB CALCULATECOLORS (h%)
WIN(h%).Wred = _RED(WIN(h%).WColor) '                                                     get RGB components of window color
WIN(h%).Wgreen = _GREEN(WIN(h%).WColor)
WIN(h%).Wblue = _BLUE(WIN(h%).WColor)
WIN(h%).Lighter = _RGB32(WIN(h%).Wred * 1.5, WIN(h%).Wgreen * 1.5, WIN(h%).Wblue * 1.5) ' calculate window/border color shades
WIN(h%).Light = _RGB32(WIN(h%).Wred * 1.25, WIN(h%).Wgreen * 1.25, WIN(h%).Wblue * 1.25)
WIN(h%).Dark = _RGB32(WIN(h%).Wred / 1.25, WIN(h%).Wgreen / 1.25, WIN(h%).Wblue / 1.25)
WIN(h%).Darker = _RGB32(WIN(h%).Wred \ 1.5, WIN(h%).Wgreen \ 1.5, WIN(h%).Wblue \ 1.5)
WIN(h%).Darkest = _RGB32(WIN(h%).Wred \ 2, WIN(h%).Wgreen \ 2, WIN(h%).Wblue \ 2)
END SUB

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                  MOUSEMOVEMENTY
FUNCTION MOUSEMOVEMENTY ()
'
' returns the mouse y coordinate difference between calls
'
STATIC y% ' previous call's mouse y coordinate (saved between calls)
MOUSEMOVEMENTY = MOUSE.Y - y% ' calculate mouse y offset from previous call
y% = MOUSE.Y '                  save current mouse y coordinate
END FUNCTION

'--------------------------------------------------------------------------------------------------------------------------------
'                                                                                                                  MOUSEMOVEMENTX
FUNCTION MOUSEMOVEMENTX ()
'
' returns the mouse x coordinate difference between calls
'
STATIC x% ' previous call's mouse x coordinate (saved between calls)
MOUSEMOVEMENTX = MOUSE.X - x% ' calculate mouse x offset from previous call
x% = MOUSE.X '                  save current mouse x coordinate
END FUNCTION

SUB createStartMenu
_DEST startb&
LINE (0, 0)-(203, 280), blackColor, BF
LINE (0, 0)-(202, 279), faceColor, BF
LINE (1, 1)-(202, 279), shadowColor, BF
LINE (1, 1)-(201, 278), whiteColor, BF
LINE (2, 2)-(201, 278), faceColor, BF
LINE (26, 41)-(198, 41), shadowColor
LINE (26, 42)-(198, 42), whiteColor
LINE (26, 241)-(198, 241), shadowColor
LINE (26, 242)-(198, 242), whiteColor
_PUTIMAGE (0, 0), startm&
END SUB

SUB createStartButton
_DEST startc&
DIM startText AS STRING
LET startText = "Start"
LINE (0, 0)-(54, 21), blackColor, BF
LINE (0, 0)-(53, 20), whiteColor, BF
LINE (1, 1)-(53, 20), shadowColor, BF
LINE (1, 1)-(52, 19), highlightColor, BF
LINE (2, 2)-(52, 19), faceColor, BF
_PUTIMAGE (3, 3), winlogo&
_FONT startFont&
COLOR _RGB(0, 0, 0)
_PRINTMODE _KEEPBACKGROUND
_PRINTSTRING (22, 6), startText
_DEST startd&
LINE (0, 0)-(54, 21), whiteColor, BF
LINE (0, 0)-(53, 20), blackColor, BF
LINE (1, 1)-(53, 20), highlightColor, BF
LINE (1, 1)-(52, 19), shadowColor, BF
LINE (2, 2)-(52, 19), faceColor, BF
_PUTIMAGE (3, 3), winlogo&
_FONT startFont&
COLOR _RGB(0, 0, 0)
_PRINTMODE _KEEPBACKGROUND
_PRINTSTRING (22, 6), startText
END SUB

SUB createTaskbar
_DEST taskbar&
LINE (0, 0)-(primary.sizeX, 27), faceColor, BF
LINE (0, 1)-(primary.sizeX, 27), whiteColor, BF
LINE (0, 2)-(primary.sizeX, 27), faceColor, BF
END SUB

SUB createSystemTray
_DEST timeloc&
LINE (0, 0)-(99, 21), whiteColor, BF
LINE (0, 0)-(98, 20), shadowColor, BF
LINE (1, 1)-(98, 20), faceColor, BF
END SUB

SUB customWindow
demoWindow1 = WIN_NEW(640, 480, BYSCREEN)
WIN_SETTITLE demoWindow1, "Demo"
WIN_SETFONT demoWindow1, titlebarFont&
WIN(demoWindow1).TBSolid = -1
WIN_MAKE demoWindow1
WIN_SHOW demoWindow1
WIN_PUT demoWindow1, 25, 25, BYWINDOW
WIN(demoWindow1).Size = -1
END SUB

SUB customWindow2
demoWindow2 = WIN_NEW(640, 384, BYSCREEN)
WIN_SETTITLE demoWindow2, "Test"
WIN_SETFONT demoWindow2, titlebarFont&
WIN(demoWindow2).TBSolid = -1
WIN_MAKE demoWindow2
WIN_SHOW demoWindow2
WIN_PUT demoWindow2, 150, 275, BYWINDOW
WIN(demoWindow2).Size = -1
END SUB

FUNCTION SHOWMENU (MenuSetup$, MenuID$, mx, my)
DIM MenuH AS SINGLE
IF LEN(MenuSetup$) = 0 THEN EXIT FUNCTION
IF mx < 0 THEN mx = 0
IF my < 0 THEN my = 0
WHILE _MOUSEBUTTON(2): mi = _MOUSEINPUT: WEND
REDIM Choices(1 TO 1) AS MenuType
TotalChoices = 1: Separators = 0
MaxLen = 25
IF INSTR(MenuSetup$, CHR$(LF)) = 0 THEN
    IF LEFT$(MenuSetup$, 1) = "~" THEN Choices(TotalChoices).Inactive = -1: MenuSetup$ = MID$(MenuSetup$, 2)
    CheckHighlight = INSTR(MenuSetup$, "&")
    Choices(TotalChoices).Highlight = CheckHighlight
    Choices(TotalChoices).Caption = LEFT$(MenuSetup$, CheckHighlight - 1) + MID$(MenuSetup$, CheckHighlight + 1)
    IF LEN(RTRIM$(Choices(TotalChoices).Caption)) > MaxLen THEN MaxLen = LEN(RTRIM$(Choices(TotalChoices).Caption))
ELSE
    Position = 0
    DO
        Position = Position + 1
        IF Position > LEN(MenuSetup$) THEN EXIT DO
        ThisChar = ASC(MenuSetup$, Position)
        SELECT CASE ThisChar
            CASE LF
                Choices(TotalChoices).Caption = TempCaption$
                IF RTRIM$(Choices(TotalChoices).Caption) = "-" THEN
                    Separators = Separators + 1
                    Choices(TotalChoices).Inactive = -1
                END IF
                IF LEN(RTRIM$(Choices(TotalChoices).Caption)) > MaxLen THEN MaxLen = LEN(RTRIM$(Choices(TotalChoices).Caption))
                TempCaption$ = ""
                IF LEN(MID$(MenuSetup$, Position + 1)) > 0 THEN
                    TotalChoices = TotalChoices + 1
                    REDIM _PRESERVE Choices(1 TO TotalChoices) AS MenuType
                END IF
            CASE 126 '~
                Choices(TotalChoices).Inactive = -1
            CASE 38 '&
                Choices(TotalChoices).Highlight = LEN(TempCaption$) + 1
            CASE ELSE
                TempCaption$ = TempCaption$ + CHR$(ThisChar)
        END SELECT
    LOOP
    IF LEN(TempCaption$) > 0 THEN Choices(TotalChoices).Caption = TempCaption$
    IF LEN(RTRIM$(Choices(TotalChoices).Caption)) > MaxLen THEN MaxLen = LEN(RTRIM$(Choices(TotalChoices).Caption))
END IF
MenuW = 120
IF _WIDTH - mx < MenuW THEN MenuX = _WIDTH - MenuW ELSE MenuX = mx
MenuH = ((TotalChoices - Separators) * (_FONTHEIGHT * 1.5)) + Separators * (_FONTHEIGHT / 2)
IF _HEIGHT - my < MenuH THEN MenuY = my - MenuH ELSE MenuY = my
DO
    GOSUB DrawMenu
    WHILE _MOUSEINPUT
        IF _MOUSEWHEEL THEN EXIT DO
    WEND
    mx = _MOUSEX
    my = _MOUSEY
    mb1 = _MOUSEBUTTON(1)
    mb2 = _MOUSEBUTTON(2)
    'Hover highlight:
    IF mx <> prev.mx OR my <> prev.my THEN
        prev.mx = mx: prev.my = my
        SelectedItem = 0
        FOR i = 1 TO TotalChoices
            IF RTRIM$(Choices(i).Caption) <> "-" THEN
                IF mx >= MenuX AND mx <= MenuX + MenuW AND my >= Choices(i).Y - (_FONTHEIGHT / 3) AND my <= Choices(i).Y + (_FONTHEIGHT * 1.5) THEN
                    SelectedItem = i
                    GOSUB Highlight
                    EXIT FOR
                END IF
            END IF
        NEXT i
    ELSE
        i = SelectedItem
        GOSUB Highlight
    END IF
    time
    _DISPLAY
    'Check for click
    IF mb1 AND mb1held = 0 THEN mb1held = -1
    IF mb1held = -1 AND mb1 = 0 THEN mb1released = -1: mb1held = 0
    'Check for mouse up:
    IF mb1released THEN
        IF mx = _MOUSEX AND my = _MOUSEY THEN
            CheckForClick:
            FOR i = 1 TO TotalChoices
                IF mx >= MenuX AND mx <= MenuX + MenuW AND my >= Choices(i).Y - (_FONTHEIGHT / 3) AND my <= Choices(i).Y + (_FONTHEIGHT * 1.5) THEN
                    ForceCheckForClick:
                    IF i = 0 THEN
                        'Enter is pressed while no choice is highlighted
                        EXIT FUNCTION
                    END IF
                    IF Choices(i).Inactive = 0 THEN
                        IF LEN(MenuID$) THEN
                            SHOWMENU = CVI(MID$(MenuID$, i * 2 - 1, 2))
                        ELSE
                            SHOWMENU = i
                        END IF
                        EXIT FUNCTION
                    END IF
                END IF
            NEXT i
            IF mx < MenuX OR mx > MenuX + MenuW OR my < MenuY OR my > MenuY + MenuH THEN
                'Click outside menu boundaries
                EXIT FUNCTION
            END IF
            mb1released = 0
        END IF
    ELSEIF mb2 THEN
        IF mx < MenuX OR mx > MenuX + MenuW OR my < MenuY OR my > MenuY + MenuH THEN
            EXIT FUNCTION
        ELSE
            GOTO CheckForClick
        END IF
    END IF
LOOP
EXIT FUNCTION
DrawMenu:
LINE (MenuX, MenuY)-STEP(MenuW, MenuH), blackColor, BF
LINE (MenuX, MenuY)-STEP(MenuW - 1, MenuH - 1), faceColor, BF
LINE (MenuX + 1, MenuY + 1)-STEP(MenuW - 1, MenuH - 1), shadowColor, BF
LINE (MenuX + 1, MenuY + 1)-STEP(MenuW - 2, MenuH - 2), whiteColor, BF
LINE (MenuX + 2, MenuY + 2)-STEP(MenuW - 3, MenuH - 3), faceColor, BF
FOR i = 1 TO TotalChoices
    IF i = 1 THEN
        Choices(i).Y = MenuY + (_FONTHEIGHT / 3)
    ELSE
        Choices(i).Y = Choices(i - 1).Y + ((_FONTHEIGHT * 1.5))
    END IF
    IF AfterSeparator THEN Choices(i).Y = Choices(i).Y - (_FONTHEIGHT)
    IF RTRIM$(Choices(i).Caption) = "-" THEN
        LINE (MenuX, Choices(i).Y - (_FONTHEIGHT * .1))-STEP(MenuW, 0), MenuBorder_COLOR
        AfterSeparator = -1
    ELSE
        IF Choices(i).Inactive THEN COLOR InactiveItem_COLOR ELSE COLOR ActiveItem_COLOR
        _PRINTSTRING (MenuX + (_PRINTWIDTH("W") * 3), Choices(i).Y), RTRIM$(Choices(i).Caption)
        AfterSeparator = 0
    END IF
    IF Choices(i).Inactive = 0 AND Choices(i).Highlight > 0 THEN
        LINE (MenuX + (_PRINTWIDTH("W") * (Choices(i).Highlight + 2)), Choices(i).Y + _FONTHEIGHT)-STEP(_PRINTWIDTH("W"), 0), ActiveItem_COLOR
    END IF
NEXT i
RETURN
Highlight:
IF i < 1 OR i > TotalChoices THEN RETURN
IF RTRIM$(Choices(i).Caption) <> "-" THEN
    LINE (MenuX, Choices(i).Y - (_FONTHEIGHT / 3))-STEP(MenuW, _FONTHEIGHT * 1.5), Highlight_COLOR, BF
    IF Choices(i).Inactive THEN COLOR InactiveItem_COLOR ELSE COLOR ActiveItemSelected_COLOR
    _PRINTSTRING (MenuX + (_PRINTWIDTH("W") * 3), Choices(i).Y), RTRIM$(Choices(i).Caption)
END IF
IF Choices(i).Inactive = 0 AND Choices(i).Highlight > 0 THEN
    LINE (MenuX + (_PRINTWIDTH("W") * (Choices(i).Highlight + 2)), Choices(i).Y + _FONTHEIGHT)-STEP(_PRINTWIDTH("W"), 0), ActiveItemSelected_COLOR
END IF
RETURN
END FUNCTION

