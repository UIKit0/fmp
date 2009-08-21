/*
 * Flash Module Player
 * Copyright (C) 2008-2009 Kostas Michalopoulos
 * 
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * 
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 * Kostas Michalopoulos <badsector@runtimeterror.com>
 */
 
import flash.media.Sound;
import flash.utils.ByteArray;
import flash.text.TextField;
import flash.events.MouseEvent;

class Test
{
    static var pb:flash.display.Sprite;
    static var mp:ModPlayer;
    static var te:flash.text.TextField;
    static var musix:Array<String>;
    static var curmus:Int = 0;
    static var lastclick:Float = 0;
    
    static function setProgress(prg:Int)
    {
        pb.graphics.clear();
        pb.graphics.beginFill(0x5ec4ee);
        pb.graphics.drawRect(0, 0, 128*prg/100, 48);
        pb.graphics.endFill();
        if (prg == 100) {
            te.text = musix[curmus] + "\n\nClick to change";
        } else te.text = "\n" + prg + "%";
    }
    
    /* ...with extra code for click-crazy people! */
    static function onteclick(ev:MouseEvent)
    {
        mp.stop();
        if (haxe.Timer.stamp() - lastclick < 0.2) {
            te.text = "\nDONT DO THIS!!!";
            lastclick = haxe.Timer.stamp();
            return;
        }
        lastclick = haxe.Timer.stamp();
        curmus++;
        if (curmus > musix.length) curmus = 0;
        if (curmus < musix.length) {
            mp = new ModPlayer();
            mp.onProgress = function(prg:Int) { setProgress(prg); }
            flash.media.SoundMixer.stopAll();
            mp.play(musix[curmus]);
        }
        else te.text = "Stopped\n\nClick to start";
    }

    static function main()
    {
        pb = new flash.display.Sprite();
        pb.addEventListener(MouseEvent.CLICK, onteclick);
        flash.Lib.current.addChild(pb);
        
        te = new TextField();
        te.width = 128;
        te.height = 48;
        te.autoSize = flash.text.TextFieldAutoSize.CENTER;
        te.addEventListener(MouseEvent.CLICK, onteclick);
        flash.Lib.current.addChild(te);
        
        try {
            var musicfiles:String = flash.Lib.current.loaderInfo.parameters.modfile;
            musix = musicfiles.split(",");
        } catch (whatever:Dynamic) {
            musix = ["game-menu.mod"];
        }
        
        lastclick = haxe.Timer.stamp();
        mp = new ModPlayer();
        mp.onProgress = function(prg:Int) { setProgress(prg); }
        mp.play(musix[0]);
    }
}

