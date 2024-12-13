/*
a*a.x + b*b.x = p.x
a*a.y + b*b.y = p.y

p.y*a.x - b*b.y*a.x + b*b.x*a.y = p.x*a.y
p.y*a.x + b*b.x*a.y - b*b.y*a.x = p.x*a.y
b*(b.x*a.y - b.y*a.x) = p.x*a.y-p.y*a.x 
b = (p.x*a.y-p.y*a.x)/(b.x*a.y - b.y*a.x)

a*a.x + b*b.x = p.x
a*a.y + b*b.y = p.y

a = (p.x*b.y-p.y*b.x)/(a.x*b.y - a.y*b.x)

*/

import haxe.Int64;
using StringTools;
using utils.PrimitiveTools;
using Lambda;
import Math.*;
import utils.Utils.*;

private typedef Input = Array<{p:{x:Float, y:Float}, a:{x:Float, y:Float}, b:{x:Float, y:Float}}>;
class Day13 implements Day {

    var input:Input;
    public function new() {}

    public function part1() {
        var total:Float = 0;

        for (p in input) {
            var aNum = (p.p.x*p.b.y - p.p.y*p.b.x);
            var aDen = (p.a.x*p.b.y - p.a.y*p.b.x);
            var bNum = (p.p.x*p.a.y - p.p.y*p.a.x);
            var bDen = (p.b.x*p.a.y - p.b.y*p.a.x);
            
            if (aNum%aDen == 0 && bNum%bDen == 0) {
                var a = aNum/aDen;
                var b = bNum/bDen;
                total += a*3 + b;
            }
        }
        return total;
    }

    public function part2() {
        var total:Float = 0;

        for (p in input) {
            p.p.x += 10000000000000;
            p.p.y += 10000000000000;
            var aNum = (p.p.x*p.b.y - p.p.y*p.b.x);
            var aDen = (p.a.x*p.b.y - p.a.y*p.b.x);
            var bNum = (p.p.x*p.a.y - p.p.y*p.a.x);
            var bDen = (p.b.x*p.a.y - p.b.y*p.a.x);
            
            if (aNum%aDen == 0 && bNum%bDen == 0) {
                var a = aNum/aDen;
                var b = bNum/bDen;
                total += a*3 + b;
            }
        }
        return total;
    }

    public function loadFile(file:String) {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var lineA = iterator.readLine();
            var lineB = iterator.readLine();
            var lineP = iterator.readLine();
            var reg = ~/[0-9]+/;
            reg.match(lineA);
            var xa = Std.parseInt(reg.matched(0));
            reg.match(reg.matchedRight());
            var ya = Std.parseInt(reg.matched(0));


            reg.match(lineB);
            var xb = Std.parseInt(reg.matched(0));
            reg.match(reg.matchedRight());
            var yb = Std.parseInt(reg.matched(0));

            reg.match(lineP);
            var xp = Std.parseInt(reg.matched(0));
            reg.match(reg.matchedRight());
            var yp = Std.parseInt(reg.matched(0));

            input.push({p:{x:xp, y:yp}, a:{x:xa, y:ya}, b:{x:xb, y:yb}});

            iterator.readLine();
        }

        iterator.close();
        this.input = input;
        return this;
    }
}
