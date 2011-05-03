===============================
Flash Module Player version 1.3
===============================

Copyright (C) 2008-2010 Kostas Michalopoulos and Mike Wiering

This is the full source code of the Flash MOD Player, an Amiga
Protracker/SoundTracker MOD music file player for Flash 9 and newer versions
written in the haXe programming language (http://www.haxe.org/). Although
written in haXe, however, FMP can be used with ActionScript 3 by converting the
haXe code in ActionScript 3 code (the haXe compiler does this).

The source code also contains DynSound, a haXe class for playing dynamically
generated sound in Flash 9 using a pre-synthesized SWF file. DynSound can be
used independently from ModPlayer.

Both the Flash MOD Player and DynSound are licensed under the zlib license.

MOD Support
===========
The module player supports most effects found in MOD files with the exception of
panning effects (there is no stereo support) and the following effects: E3, E5
and E6 (will added soon). Also due to the way the module player works (see docs)
0B is limited to jumping to orders below (after) the current order (so no
looping).

Documentation
=============
The documentation is in SlashDOC comment format. SlashDOC is a documentation
generation tool similar to JavaDoc but for C, C++, haXe and several other
languages i developed. The latest release of SlashDOC does not support haXe,
but you need to download a development version from the repository. For more
information visit https://github.com/badsector/slashdoc.

Of course the documentation markup is very readable and you can just read the
documentation comments in the haXe source code if you don't want to generate or
read HTML documentation.

Using
=====

1. Simple MOD Playback
----------------------
To perform simple MOD playback from a file in your server:

    mp = new ModPlayer();
    mp.play("music.mod");

If you want to get progress information while the module is download and the
soundwave is generated:

    static function onProgress(prg:Int)
    {
        /* do something with prg here */
    }
    
    ...
    
    mp = new ModPlayer();
    mp.onProgress = onProgress;
    mp.play("music.mod");

2. Repeating and stereo
-----------------------
By default repeating is enabled. To disable do:

    mp.setRepeating(false);

Thanks to Mike Wiering's patch, since version 1.3 FMP and DynSound
have stereo playback support. To enable it use

    mp.setStereo(true);

Stereo playback increases precalculation time and memory synthesis,
though, so make sure it does make a significant difference :-).

3. Stopping
-----------
Stopping isn't really supported in a per-MODPlayer basis because of Flash 9
limitations. This will be fixed in a future Flash 10 version. Anyway, to stop a
module just call:

    mp.stop();

Note, however that calling stop() and play() while a previously waveform is
generated might result in a nonterminating situation. This shouldn't be a
problem in the majority of cases when you have total control of playback and
stop time (like in a game), but if you want to be safe just create a new
MODPlayer object. Note that stopping and starting playback might still make some
sounds to play at the same time. To undo this, call stop.

This sort of behavior happens because of Flash 9's limitations (see the About
page). A future Flash 10 version will probably not have these issues (which,
however, are not very important in real-life uses).

4. Embedded MODs
----------------
To embed MODs in a SWF in haXe you can use either the -resource argument or
SWFMill and the <binary> tag. Both of these methods will provide you with a
ByteArray object which you can feed to ModPlayer's playBytes.

Please note: in haXe 2.03 the -resource is broken for Flash targets and if you
use big resources (more than 32kb maybe) it will make the Flash Player to crash!
Prefer binary data embedded via a SWF library using SWFmill

5. XM support
-------------
Mike Wiering added initial XM support for 1.3. Currently not all
commands are supported and there is little testing done. The following
commands are known to not be supported:

         Kxx (key off after xx ticks)
         Lxx (set volume envelope position)
         R.. (retrigger note with volume slide)
         Txy (tremor)
         Xxy (extra fine portamento)

Also envelopes are currently not supported.
         
Files
=====
The source code distribution is made up of the following files:

    authors.txt     List of authors.
    compile.hxml    haXe compile file for the Test.hx test SWF
    changes.txt     Changes between versions
    docinfo.txt     SlashDOC configuration file
    DynSound.hx     The DynSound class
    license.txt     Flash MOD Player (and DynSound) license text
    Makefile        Makefile. Creates as3 source code and SWF from ModPlayer.
    ModPlayer.hx    The Flash MOD Player classes (ModPlayer is what you want).
    readme.txt      This file
    Test.hx         A small test. This is the player in FMP's site.

To use Flash MOD Player you only need DynSound.hx and ModPlayer.hx.

Contact
=======
You can contact me via email at:

    badsectoracula@gmail.com

Flash MOD Player's page is located at:

    https://github.com/badsector/fmp (github repository view)

My webpage is located at:

    http://www.runtimelegend.com/ (Flash games, see FMP in action)

