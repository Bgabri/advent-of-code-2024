using StringTools;
using Lambda;
using utils.PrimitiveTools;
import Math.*;
import utils.Utils.*;

// haxe build.hxml 14
private typedef Input = Array<{p:{x:Int, y:Int}, v:{x:Int, y:Int}}>;
class Day14 implements Day {

    var input:Input;

    public function new() {}

    public function part1() {
        var steps = 100;
        var sizeX = 101;
        var sizeY = 103;

        for (r in input) {
            r.p.x = (r.p.x + r.v.x*steps)%sizeX;
            r.p.y = (r.p.y + r.v.y*steps)%sizeY;
            if (r.p.x < 0) r.p.x = sizeX + r.p.x;
            if (r.p.y < 0) r.p.y = sizeY + r.p.y;
        }

        var q1 = 0; 
        var q2 = 0;
        var q3 = 0;
        var q4 = 0;
        var aa  = [for (i in 0...sizeY) [for (j in 0...sizeX) 0]];

        for (r in input) {
            aa[r.p.y][r.p.x]++;
            if (r.p.x > floor(sizeX/2)) {
                if (r.p.y > floor(sizeY/2)) q1++;
                else if (r.p.y < floor(sizeY/2)) q2++;
                
            }
            else if (r.p.x < floor(sizeX/2)) {
                if (r.p.y > floor(sizeY/2)) q3++;
                else if (r.p.y < floor(sizeY/2)) q4++;
            }
        }

        return q1*q2*q3*q4;
    }

    function variance(map:Input) {
        var avrgX = 50;
        var avrgY = 51;
        
        var varianceX = 0;
        var varianceY = 0;
        for (v in map) {
            varianceX += abs(avrgX - v.p.x);
            varianceY += abs(avrgY - v.p.y);
        }

        return varianceX < 20*map.length && varianceY < 20*map.length;
    }

    public function part2() {
        var sizeX = 101;
        var sizeY = 103;
        
        var xmasStep = 0;
        while (!variance(input)) {
            for (r in input) {
                r.p.x = (r.p.x + r.v.x)%sizeX;
                r.p.y = (r.p.y + r.v.y)%sizeY;
                if (r.p.x < 0) r.p.x = sizeX + r.p.x;
                if (r.p.y < 0) r.p.y = sizeY + r.p.y;
            }
            xmasStep++;
        }

        var pic  = [for (i in 0...sizeY) [for (j in 0...sizeX) 0]];
        for (r in input) pic[r.p.y][r.p.x]++;
        pic.prettyPrint((n) -> n == 0 ? "\x1b[2m.\x1b[0m" : "\x1b[32m#\x1b[0m");

        return xmasStep;
    }

    public function loadFile(file:String) {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "")
                continue;

            var reg = ~/-?\d+/;
            reg.match(line);
            var px = Std.parseInt(reg.matched(0));
            line = reg.matchedRight();
            reg.match(line);
            var py = Std.parseInt(reg.matched(0));
            line = reg.matchedRight();
            reg.match(line);
            var vx = Std.parseInt(reg.matched(0));
            line = reg.matchedRight();
            reg.match(line);
            var vy = Std.parseInt(reg.matched(0));
            input.push({p:{x:px, y:py},v:{x:vx, y:vy}});
        }
        iterator.close();
        this.input = input;
        return this;
    }
}
