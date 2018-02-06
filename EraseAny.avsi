##################################################################################################
### Function  : EraseAny
### Author    : ema
### Version   : v0.4
### Release   : 2018.01.16
##################################################################################################
### Be used for erase any transparent logo.
### YV12 and YV24 Only.
###
### an [int, default: 0] 
### ------------------
###    >> Using for EraseAny.
###    The alignment parameter takes a number from 1 to 9, corresponding to the positions of the keys on a numpad.
###    But when alignment equals 0, it's equivalent to full screen.
###
### l/t/r/b [int, default: 0]
### ------------------
###    Crop is the simplest to use of the two. The arguments specify how many pixels to crop from each side. This function used to be called CropRel which is still an alias for it.
###    left/top/right/bottom pixels to be cropped for logo area.
###
### x/y/width/height [int, default: 0]
### ------------------
###    left/top/right/bottom pixels to be cropped for logo area.
###    CropAbs, on the other hand, is special, because it can accept clips with variable frame sizes and crop out a fixed size area, thus making it a fixed size clip.
###
### d/a/s/h [int, default: 1/2/4/6]
### ------------------
###    The same parameters of KNLMeansCL.
###
### pos_x / pos_y [int, default: 0/0]
### ------------------
###    Adjust logo position, in a quarter pixel.
###
### device_type [string, default: 'gpu']
### ------------------
###    'accelerator' := Dedicated OpenCL accelerators.
###    'cpu' := An OpenCL device that is the host processor.
###    'gpu' := An OpenCL device that is a GPU.
###    'auto' := 'accelerator' -> 'gpu' -> 'cpu'.
### 
### device_id [int, default: 1]
### ------------------
###    The 'device_id' device of type 'device_type' in the system.
###    Example: [device_type = "GPU", device_id = 1] return the second GPU in the system.
###
### +----------------+
### |  REQUIREMENTS  |
### +----------------+
###	-> LogoNR
### 	-> KNLMeansCL
### 	-> delogo
### 	-> mt_masktools-26
### 	-> RemoveGrain
##################################################################################################
function EraseAny(clip src, string lgd, bool "chroma", int "l", int "t", int "r", int "b", int "_d", int "_a", int "_s", int "_h", int "fadein", int "fadeout", int "start", int "end", bool "interlaced", string "device_type", int "device_id")
{
    chroma = Default(chroma, true)
    device_type = Default(device_type, "gpu")
    device_id = Default(device_id, 1)
    l = Default(l, 0)
    t = Default(t, 0)
    r = Default(r, 0)
    b = Default(b, 0)
    _d = Default(_d, 1)
    _a = Default(_a, 2)
    _s = Default(_s, 2)
    _h = Default(_h, 3)
    fadein = Default(fadein, 0)
    fadeout = Default(fadeout, 0)
    start = Default(start, 0)
    end = (fadeout == 0) ? Default(end, src.FrameCount()) :  Default(end, src.FrameCount() - 3)
    interlaced = Default(interlaced, false)
    return LogoNR(EraseLOGO(src, lgd, fadein=fadein, fadeout=fadeout, start=start, end=end, interlaced=interlaced), src, chroma=chroma, l=l, t=t, r=r, b=b, _d=_d, _a=_a, _s=_s, _h=_h, device_type=device_type, device_id=device_id)
}

function EraseAny(clip src, string lgd, bool "chroma", int "an", int "_d", int "_a", int "_s", int "_h", int "fadein", int "fadeout", int "start", int "end", bool "interlaced", string "device_type", int "device_id")
{
    chroma = Default(chroma, true)
    device_type = Default(device_type, "gpu")
    device_id = Default(device_id, 1)
    an = Default(an, 0)
    _d = Default(_d, 1)
    _a = Default(_a, 2)
    _s = Default(_s, 2)
    _h = Default(_h, 3)
    fadein = Default(fadein, 0)
    fadeout = Default(fadeout, 0)
    start = Default(start, 0)
    end = (fadeout == 0) ? Default(end, src.FrameCount()) :  Default(end, src.FrameCount() - 3)
    interlaced = Default(interlaced, false)
    w = src.Width()
    h = src.Height()
    l =     (an == 1) ? 0
        \ : (an == 2) ? w/3
        \ : (an == 3) ? w/3*2
        \ : (an == 4) ? 0
        \ : (an == 5) ? w/3
        \ : (an == 6) ? w/3*2
        \ : (an == 7) ? 0
        \ : (an == 8) ? w/3
        \ : (an == 9) ? w/3*2
        \ : 0
    t =    (an == 1) ? h/3*2
        \ : (an == 2) ? h/3*2
        \ : (an == 3) ? h/3*2
        \ : (an == 4) ? h/3
        \ : (an == 5) ? h/3
        \ : (an == 6) ? h/3
        \ : (an == 7) ? 0
        \ : (an == 8) ? 0
        \ : (an == 9) ? 0
        \ : 0
    r =    (an == 1) ? -w/3*2
        \ : (an == 2) ? -w/3
        \ : (an == 3) ? -0
        \ : (an == 4) ? -w/3*2
        \ : (an == 5) ? -w/3
        \ : (an == 6) ? -0
        \ : (an == 7) ? -w/3*2
        \ : (an == 8) ? -w/3
        \ : (an == 9) ? -0
        \ : 0
    b =    (an == 1) ? -0
        \ : (an == 2) ? -0
        \ : (an == 3) ? -0
        \ : (an == 4) ? -h/3
        \ : (an == 5) ? -h/3
        \ : (an == 6) ? -h/3
        \ : (an == 7) ? -h/3*2
        \ : (an == 8) ? -h/3*2
        \ : (an == 9) ? -h/3*2
        \ : 0

    return LogoNR(EraseLOGO(src, lgd, fadein=fadein, fadeout=fadeout, start=start, end=end, interlaced=interlaced), src, chroma=chroma, l=l, t=t, r=r, b=b, _d=_d, _a=_a, _s=_s, _h=_h, device_type=device_type, device_id=device_id)
}

Function EraseAny(clip src, string lgd, bool "chroma", int "x", int "y", int "w", int "h", int "_d", int "_a", int "_s", int "_h", int "fadein", int "fadeout", int "start", int "end", bool "interlaced", string "device_type", int "device_id")
{
    chroma = Default(chroma, true)
    device_type = Default(device_type, "gpu")
    device_id = Default(device_id, 1)
    _d = Default(_d, 1)
    _a = Default(_a, 2)
    _s = Default(_s, 2)
    _h = Default(_h, 3)
    x = Default(x, 0)
    y = Default(y, 0)
    w = Default(src.Width(), 0)
    h = Default(src.Height(), 0)
    fadein = Default(fadein, 0)
    fadeout = Default(fadeout, 0)
    start = Default(start, 0)
    end = (fadeout == 0) ? Default(end, src.FrameCount()) :  Default(end, src.FrameCount() - 3)
    interlaced = Default(interlaced, false)
    l = x
    t = y
    r = src.Width() - x - w
    b = src.Height() - y - h
    return LogoNR(EraseLOGO(src, lgd, fadein=fadein, fadeout=fadeout, start=start, end=end, interlaced=interlaced), src, chroma=chroma, l=l, t=t, r=r, b=b, _d=_d, _a=_a, _s=_s, _h=_h, device_type=device_type, device_id=device_id)
}


##################################################################################################
### Function  : LogoNR
### Author    : 06_taro
### Version   : v0.1
### Release   : 2012.04.22
##################################################################################################
### Post-denoise filter of EraseLogo.
### Only process logo areas in logo frames, even if l/t/r/b are not set. Non-logo areas are left untouched.
###
### +---------+
### |  USAGE  |
### +---------+
###
### dlg [clip]
### ------------------
###    Clip after delogo.
###
### src [clip]
### ------------------
###    Clip before delogo.
###
### chroma [bool, default: True]
### ------------------
###    Process chroma plane or not.
###
### l/t/r/b [int, default: 0]
### ------------------
###    left/top/right/bottom pixels to be cropped for logo area.
###    Have the same restriction as CropRel, e.g., no odd value for YV12.
###    logoNR only filters the logo areas in logo frames, no matter l/t/r/b are set or not.
###    So if you have other heavy filters running in a pipeline and don't care much about the speed of logoNR,
###    it is safe to left these values unset.
###    Setting these values only makes logoNR run faster, with rarely noticeable difference in result,
###    unless you set wrong values and the logo is not covered in your cropped target area.
###
### d/a/s/h [int, default: 1/2/4/6]
### ------------------
###    The same parameters of KNLMeansCL.
###
### device_type [string, default: 'gpu']
### ------------------
###    'accelerator' := Dedicated OpenCL accelerators.
###    'cpu' := An OpenCL device that is the host processor.
###    'gpu' := An OpenCL device that is a GPU.
###    'auto' := 'accelerator' -> 'gpu' -> 'cpu'.
### 
### device_id [int, default: 1]
### ------------------
###    The 'device_id' device of type 'device_type' in the system.
###    Example: [device_type = "GPU", device_id = 1] return the second GPU in the system.
###
### +----------------+
### |  REQUIREMENTS  |
### +----------------+
### 	-> KNLMeansCL
### 	-> delogo
### 	-> mt_masktools-26
### 	-> RemoveGrain
##################################################################################################
function LogoNR(clip dlg, clip src, int "l", int "t", int "r", int "b", int "_d", int "_a", int "_s", int "_h", bool "chroma", string "device_type", int "device_id")
{
    chroma = Default(chroma, true)
    device_type = Default(device_type, "gpu")
    device_id = Default(device_id, 1)
    l = Default(l, 0)
    t = Default(t, 0)
    r = Default(r, 0)
    b = Default(b, 0)
    _d = Default(_d, 1)
    _a = Default(_a, 2)
    _s = Default(_s, 2)
    _h = Default(_h, 3)

    b_crop = l==0 && t==0 && r==0 && b==0 ? false : true
    src    = b_crop ? src.Crop(l, t, r, b) : src
    last   = b_crop ? dlg.Crop(l, t, r, b) : dlg
    
    try{
        clp_nr = KNLMeansCL(d=_d, a=_a, s=_s, h=_h, device_type="gpu", device_id=1)
    }
    catch(err_msg){
        clp_nr = KNLMeansCL(d=_d, a=_a, s=_s, h=_h, device_type="gpu", device_id=0)
    }
    
    logoM  = mt_lutxy(src, "x y - Abs 4 <<", U=chroma?3:1, V=chroma?3:1)
    \        .mt_expand(mode=mt_diamond(3), U=chroma?3:1, V=chroma?3:1)
    \        .RemoveGrain(19, chroma?19:-1)
    \        .mt_deflate(U=chroma?3:1, V=chroma?3:1)

    return b_crop ? Overlay(dlg, clp_nr, x=l, y=t) : clp_nr
}
