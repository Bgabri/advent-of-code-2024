using StringTools;
using utils.PrimitiveTools;
using Lambda;
import Math.*;

// haxe build.hxml 06
private  typedef Input = Array<Array<String>>;
class Day06 implements Day {

    var input:Input;

    public function new() {}

    static function step(world:Input, x, y) {
        var line = world[y];
        var c = line[x];
        var dt = switch c {
            case "^": {c: "^", x: x,   y: y-1};
            case "v": {c: "v", x: x,   y: y+1};
            case "<": {c: "<", x: x-1, y: y  };
            case ">": {c: ">", x: x+1, y: y  };
            case _: throw "huh?";
        }

        if (world[dt.y] != null && world[dt.y][dt.x] == "#") {
            return switch c {
                case "^": {c: ">", x: x, y: y};
                case "v": {c: "<", x: x, y: y};
                case "<": {c: "^", x: x, y: y};
                case ">": {c: "v", x: x, y: y};
                case _: throw "huh?";
            }
        }

        return dt;
    }


    public function part1() {
        var xP = 0;
        var yP = 0;
        var count:Array<Array<Int>> = [];
        for (y in 0...input.length) {
            count.push([]);
            for (x in 0...input[y].length) {
                count[y].push(0);
                var c = input[y][x];
                switch c {
                    case "^": xP = x; yP = y;
                    case "v": xP = x; yP = y;
                    case "<": xP = x; yP = y;
                    case ">": xP = x; yP = y;
                }
            }

        }

        while (true) {
            var n = step(input, xP, yP);
            count[yP][xP] ++;
            if (0 > n.y || n.y >= input.length) break;
            if (0 > n.x || n.x >= input[n.y].length) break;
            input[yP][xP] = ".";
            input[n.y][n.x] = n.c;
            xP = n.x;
            yP = n.y;
        }

        var total = 0;
        for (line in count) {
            total += line.count((x)-> x > 0);
        }

        return total;
    }

    public function part2() {
        var xP = 0;
        var yP = 0;
        for (y in 0...input.length) {
            for (x in 0...input[y].length) {
                var c = input[y][x];
                switch c {
                    case "^": xP = x; yP = y;
                    case "v": xP = x; yP = y;
                    case "<": xP = x; yP = y;
                    case ">": xP = x; yP = y;
                }
            }
        }

        var total = 0;
        for (y in 0...input.length) {
            for (x in 0...input[y].length) {
                if (input[y][x] == "#" || input[y][x] == "^") continue;
                input[y][x] = "#";
                var px = xP;
                var py = yP;

                var steps = 0;
                var max = input.length*input.length/2;
                while (steps < max) {
                    var n = step(input, px, py);
                    if (input[n.y] == null) break;
                    if (input[n.y][n.x] == null) break;

                    input[py][px] = ".";
                    input[n.y][n.x] = n.c;
                    px = n.x;
                    py = n.y;
                    steps++;
                }
                if (steps == max) total++;
                input[py][px] = ".";
                input[y][x] = ".";
                input[yP][xP] = "^";
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

            input.push(line.split(""));
        }
        iterator.close();
        this.input = input;
        return this;
    }
}
