using StringTools;
using utils.PrimitiveTools;
using Lambda;
import Math.*;
import utils.Utils.*;

// haxe build.hxml 10
private typedef Input = Array<Array<Int>>;
class Day10 implements Day {

    var input:Input;

    public function new() {}

    static var pp:Input = [];

    static function ascend(map:Input, x:Int, y:Int, prev:Int) {
        if (0 > y || y >= map.length) return 0;
        if (0 > x || x >= map[y].length) return 0;
        if (map[y][x] != prev + 1) return 0;
        if (map[y][x] == 9) {
            map[y][x] = -1;
            return 1;
        }
        prev++;
        return ascend(map, x + 1, y, prev) +
               ascend(map, x, y + 1, prev) +
               ascend(map, x - 1, y, prev) +
               ascend(map, x, y - 1, prev);
    }

    public function part1() {
        var total = 0;

        for (i in 0...input.length) {
            for (j in 0...input[i].length) {
                if (input[i][j] != 0) continue;
                total += ascend(input.clone(), j, i, -1);
            }
        }
        return total;
    }


    static function ascend2(map:Input, x:Int, y:Int, prev:Int) {
        if (0 > y || y >= map.length) return 0;
        if (0 > x || x >= map[y].length) return 0;
        if (map[y][x] != prev + 1) return 0;
        if (map[y][x] == 9) return 1;
        prev++;
        return ascend2(map, x + 1, y, prev) +
               ascend2(map, x, y + 1, prev) +
               ascend2(map, x - 1, y, prev) +
               ascend2(map, x, y - 1, prev);
    }

    public function part2() {
        var total = 0;

        for (i in 0...input.length) {
            for (j in 0...input[i].length) {
                if (input[i][j] != 0) continue;
                total += ascend2(input, j, i, -1);
            }
        }
        return total;
    }

    public function loadFile(file:String) {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "")
                continue;

            var inp = line.split("");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp2);
        }
        iterator.close();
        this.input = input;
        return this;
    }
}
