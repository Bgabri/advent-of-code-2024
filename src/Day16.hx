import utils.FilePath.FilePathImp;
using StringTools;
using Lambda;
using utils.PrimitiveTools;
import Math.*;
import utils.Utils.*;

// haxe build.hxml 16
private typedef Input = Array<Array<String>>;
class Day16 implements Day {

    var input:Input;
    // final MAX:Int =  1<<31-1;
    final MAX:Int =  9999999;

    public function new() {}


    public function shortestPath(p:{x:Int, y:Int}, d:{x:Int, y:Int}, map:Input, visited:Array<Array<Int>>, score:Int) {
        if (visited[p.y][p.x] < score) return MAX;
        if (map[p.y][p.x] == "#") return MAX;
        visited[p.y-d.y][p.x-d.x] = score;
        // visited[p.y][p.x] = score;
        if (map[p.y][p.x] == "E") return score;

        var l = {x: d.y != 0 ? -1 : 0, y: d.x != 0 ? -1 : 0};
        var r = {x: d.y != 0 ?  1 : 0, y: d.x != 0 ?  1 : 0};
        
        var pl = {x: p.x + l.x, y: p.y + l.y};
        var pr = {x: p.x + r.x, y: p.y + r.y};
        var left  = shortestPath(pl, l, map, visited, score + 1001);
        var right = shortestPath(pr, r, map, visited, score + 1001);
        var p = {x: p.x + d.x, y: p.y + d.y};
        var straight = shortestPath(p, d, map, visited, score + 1);

        return min(min(straight, left), right);
    }

    public function part1() {
        var total = MAX;
        var vs = [for (i in 0...input.length) [for (j in 0...input[i].length) MAX]];
        total = shortestPath({x:1, y:input.length - 2}, {x:1, y:0}, input, vs, 0);
        return total;
    }

    public function gradientDescent(px:Int, py:Int, prev:Int, map:Array<Array<Int>>) {
        var current = map[py][px];
        if (current >= prev) return 0;

        input[py][px] = "X";

        return gradientDescent(px, py-1, current, map) +
               gradientDescent(px, py+1, current, map) +
               gradientDescent(px-1, py, current, map) +
               gradientDescent(px+1, py, current, map) + 1;
    }

    public function part2() {
        var total = MAX;

        var vs = [for (i in 0...input.length) [for (j in 0...input[i].length) MAX]];
        
        total = shortestPath({x:1, y:input.length - 2}, {x:1, y:0}, input, vs, 0);
        vs[1][input[1].length-2] = total + 1;
        total = gradientDescent(input[1].length-2, 1, total+2, vs);

        // input.prettyPrint(v -> if (v == "X") "\x1b[33mX\x1b[0m" else v);
        total = input.fold((l, t)-> t + l.fold((c, tt) -> tt + (c == "X" ? 1 : 0), 0), 0);
        return total-1;
    }

    public function loadFile(file:String) {
        var input:Input = [];
        var f = new FilePathImp(file);
        
        var inp = f.getContent();
        input = inp.split("\n").map((line) -> line.split(""));
        if (input[input.length -1].length == 0) input.pop();
        
        this.input = input;
        return this;
    }
}
