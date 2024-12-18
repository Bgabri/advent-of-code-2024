import utils.FilePath.FilePathImp;
using StringTools;
using Lambda;
using utils.PrimitiveTools;
import Math.*;
import utils.Utils.*;

// haxe build.hxml 18
private typedef Input = Array<Array<Int>>;
class Day18 implements Day {

    var input:Input;
    final MAX:Int = 2147483647;

    public function new() {}

    function shortestPath(px:Int, py:Int, map:Array<Array<Int>>, score) {
        if (py < 0 || py >= map.length) return;
        if (px < 0 || px >= map[py].length) return;

        if (map[py][px] <= score) return;
        map[py][px] = score;
        
        shortestPath(px + 1, py, map, score + 1);
        shortestPath(px - 1, py, map, score + 1);
        shortestPath(px, py + 1, map, score + 1);
        shortestPath(px, py - 1, map, score + 1);
    }

    public function part1() {

        var n = 71;
        var map = [for (i in 0...n) [for (j in 0...n) MAX]];
        for (i in 0...1024) {
            var c = input[i];
            map[c[1]][c[0]] = -1;
        }
        shortestPath(0, 0, map, 0);

        return map[n-1][n-1];
    }

    public function part2() {
        var n = 71;
        var min = 1024;
        var max = input.length;

        while (min < max) {
            var m = min + div((max - min), 2);

            var map = [for (i in 0...n) [for (j in 0...n) MAX]];

            for (i in 0...m) {
                var c = input[i];
                map[c[1]][c[0]] = -1;
            }

            shortestPath(0, 0, map, 0);

            if (map[n-1][n-1] == -1 || map[n-1][n-1] == MAX) {
                max = m;
            } else {
                min = m + 1;
            }
        }

        return input[min - 1].join(",");
    }

    public function loadFile(file:String) {
        var input:Input = [];
        var f = new FilePathImp(file);
        
        var inp = f.getContent();

        input = inp.split("\n").map((line) -> line.split(",").map(Std.parseInt));
        input = input.filter(v -> v.length != 0);

        this.input = input;
        return this;
    }
}
