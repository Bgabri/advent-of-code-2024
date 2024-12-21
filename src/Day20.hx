import utils.FilePath.FilePathImp;
using StringTools;
using Lambda;
using utils.PrimitiveTools;
import Math.*;
import utils.Utils.*;

private typedef Vec = {x:Int, y:Int};
private typedef Vec3 = {x:Int, y:Int, z:Int};
private typedef A<V> = Array<V>;
private typedef AA<V> = Array<Array<V>>;


// haxe build.hxml 20
private typedef Input = AA<String>;
class Day20 implements Day {

    var input:Input;
    final MAX:Int = 2147483647;


    public function new() {}


    function shortestPath(px:Int, py:Int, map:AA<Int>, score) {
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
        var total = 0;
        var start = {x:0, y:0};
        var end = {x:0, y:0};
        var map:AA<Int> = [];
        for (i in 0...input.length) {
            map.push([]);
            for (j in 0...input[i].length) {
                map[i][j] = MAX;
                if (input[i][j] == "S") {
                    start.x = j;
                    start.y = i;
                } else if (input[i][j] == "E") {
                    end.x = j;
                    end.y = i;
                } else if (input[i][j] == "#") { 
                    map[i][j] = -1;
                }
            }
        }

        shortestPath(start.x, start.y, map, 0);

        var shortest = map[end.y][end.x];
        
        var diffs:Map<Int, Int> = [];
        var ns = [{x: 2, y: 0}, {x:-2, y: 0}, {x: 0, y: 2}, {x: 0, y: -2}];
        for (i in 0...input.length) {
            for (j in 0...input[i].length) {
                if (input[i][j] == "#") continue;
                for (n in ns) {
                    if (input[i + n.y] == null) continue;
                    if (input[i + n.y][j + n.x] == "#") continue;

                    var endWeight = map[i + n.y][j + n.x];
                    var startWeight = map[i][j];
                    var newWeight = shortest - endWeight + startWeight + 2;
                    var diff =  shortest - newWeight;
                    if (!diffs.exists(diff)) diffs[diff]=0;
                    diffs[diff]++;
                }
            }
        }

        for (k => v in diffs) {
            if (k >= 100) total += v;
        }

        return total;
    }


    function generateNeighbours(N) {
        var ns:A<Vec> = [];
        for (i in -N...N+1) {
            for (j in -N...N+1) {
                if (abs(i) == 0 && abs(j) == 0) continue;
                if (abs(i) + abs(j) <= N) {
                    ns.push({x: j, y:i});
                }
            }
        }

        return ns;
    }
    public function part2() {
        var total = 0;
        var start = {x:0, y:0};
        var end = {x:0, y:0};
        var map:AA<Int> = [];
        for (i in 0...input.length) {
            map.push([]);
            for (j in 0...input[i].length) {
                map[i][j] = MAX;
                if (input[i][j] == "S") {
                    start.x = j;
                    start.y = i;
                } else if (input[i][j] == "E") {
                    end.x = j;
                    end.y = i;
                } else if (input[i][j] == "#") { 
                    map[i][j] = -1;
                }
            }
        }

        shortestPath(start.x, start.y, map, 0);

        var shortest = map[end.y][end.x];
        var ns = generateNeighbours(20);
        var ends = [{x: 1, y: 0}, {x:-1, y: 0}, {x: 0, y: 1}, {x: 0, y: -1}];
        var diffs:Map<Int, Int> = [];
        for (i in 1...input.length-1) {
            for (j in 1...input[i].length-1) {

                if (input[i][j] == "#") continue;
                for (n in ns) {
                    if (input[i + n.y] == null) continue;
                    if (input[i + n.y][j + n.x] == "#") continue;

                    var endWeight = map[i + n.y][j + n.x];
                    var startWeight = map[i][j];
                    var newWeight = shortest - endWeight + startWeight + abs(n.x) + abs(n.y);
                    var diff =  shortest - newWeight;
                    if (!diffs.exists(diff)) diffs[diff] = 0;
                    diffs[diff]++;
                }
            }
        }

        total = 0;
        for (k => v in diffs) {
            if (k >= 100) total += v;
        }

        return total;
    }

    public function loadFile(file:String) {
        var input:Input = [];
        var f = new FilePathImp(file);
        
        var inp = f.getContent();

        input = inp.split("\n").map((line) -> line.split(""));
        input = input.filter(v -> v.length != 0);

        this.input = input;
        return this;
    }
}
