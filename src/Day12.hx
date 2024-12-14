using StringTools;
using utils.PrimitiveTools;
using Lambda;
import Math.*;
import utils.Utils.*;

// haxe build.hxml 12
private typedef Input = Array<Array<String>>;
class Day12 implements Day {

    var input:Input;

    public function new() {}

    static function floodFill(c:String, map:Input, x:Int, y:Int) {
        if (map[y] == null) return {a:0, p:1};
        if (map[y][x] == null) return {a:0, p:1};
        if (map[y][x] == ".") return {a:0, p:0};
        if (c != map[y][x]) return {a:0, p:1};
        map[y][x] = ".";
        
        var u = floodFill(c, map,x, y-1);
        var d = floodFill(c, map,x, y+1);
        var l = floodFill(c, map, x-1, y);
        var r = floodFill(c, map, x+1, y);
        var a = u.a + d.a + l.a + r.a+1;
        var p = u.p + d.p + l.p + r.p;
        return {a:a, p:p};
    }

    
    public function part1() {

        var total = 0;
        for (y in 0...input.length) {
            var line = input[y];
            for (x in 0...line.length) {
                var char = input[y][x];
                if (char != "." && char != "#") {
                    var c = floodFill(char, input,x, y);
                    total += c.a*c.p;
                    for (ll in 0...input.length) input[ll] = input[ll].map((s)-> if (s ==".") "#" else s);
                }
            }
        }

        return total;
    }

    static function countCorners(map:Input) {
        var n = map.length;
        var verts = [for (line in 0...(n+2)*2) [for (v in 0...(n+2)*2) 0]];

        for (y in 1...n+1) {
            for (x in 1...n+1) {
                if (map[y-1][x-1] == ".") {
                    var y = y*2;
                    var x = x*2;
                    verts[y][x] = 1;
                    verts[y][x+1] = 1;
                    verts[y+1][x] = 1;
                    verts[y+1][x+1] = 1;
                }
            }
        }

        var corners = 0;
        for (y in 1 ... verts.length-1) {
            for (x in 1 ... verts.length-1) {
                var u = verts[y-1][x];
                var d = verts[y+1][x];
                var l = verts[y][x-1];
                var r = verts[y][x+1];

                var c1 = verts[y-1][x-1];
                var c2 = verts[y+1][x+1];
                var c3 = verts[y+1][x-1];
                var c4 = verts[y-1][x+1];
                var s = u+d+l+r;
                if (verts[y][x] == 1 && s % 2 == 0 && c1 + c2 + c3 + c4 > 0) {
                    corners++;
                }
            }
        }

        return corners;
    }

    public function part2() {
        var total = 0;
        for (y in 0...input.length) {
            var line = input[y];
            for (x in 0...line.length) {
                var char = input[y][x];
                if (char != "." && char != "#") {
                    var c = floodFill(char, input,x, y);
                    var aa = countCorners(input);
                    total += c.a*aa;
                    for (ll in 0...input.length) input[ll] = input[ll].map((s)-> if (s ==".") "#" else s);
                }
            }
        }
        return total;
    }

    public function loadFile(file:String) {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "") break;

            var inp = line.split("");
            input.push(inp);
        }
        iterator.close();
        this.input = input;
        return this;
    }
}
