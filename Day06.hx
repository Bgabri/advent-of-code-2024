using StringTools;
using PrimitiveTools;
using Lambda;
import Math.*;

// haxe --interp --main Day06.hx
typedef Input = Array<Array<String>>;
class Day06 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/06.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/06.txt")));
    }


    static function step(world:Input, x, y) {
        var line = world[y];
        var c = line[x];
        var u = (y-1 < 0)             ? "." : world[y-1][x];
        var d = (y+1 >= world.length) ? "." : world[y+1][x];
        var l = (x-1 < 0)             ? "." : world[y][x-1];
        var r = (x+1 >= line.length)  ? "." : world[y][x+1];
        return switch [c, u, d, l, r] {
            case ["^","#", _ , _ , _ ]: {c: ">", x: x, y: y};
            case ["v", _ ,"#", _ , _ ]: {c: "<", x: x, y: y};
            case ["<", _ , _ ,"#", _ ]: {c: "^", x: x, y: y};
            case [">", _ , _ , _ ,"#"]: {c: "v", x: x, y: y};

            case ["^",".", _ , _ , _ ]: {c: "^", x: x,   y: y-1};
            case ["v", _ ,".", _ , _ ]: {c: "v", x: x,   y: y+1};
            case ["<", _ , _ ,".", _ ]: {c: "<", x: x-1, y: y  };
            case [">", _ , _ , _ ,"."]: {c: ">", x: x+1, y: y  };
            // case [".","v", _ , _ , _ ]: {c: "v", x: x, y:y };
            // case [".", _ ,"^", _ , _ ]: {c: "^", x: x, y:y };
            // case [".", _ , _ ,">", _ ]: {c: ">", x: x, y:y };
            // case [".", _ , _ , _ ,"<"]: {c: "<", x: x, y:y };
            case _: {c: c, x: x, y: y};
        }
    }


    static function part1(input:Input) {
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
        
        // for (line in input) {
        //     trace(line);
        // }

        var total = 0;
        for (line in count) {
            total += line.count((x)-> x > 0);
            // trace(line);
        }

        return total;
    }

    static function part2(input:Input) {
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

        var total = 0;
        for (y in 0...input.length) {
            for (x in 0...input[y].length) {
                var count2 = count.clone();
                var world = input.clone();
                world[y][x] = "#";
                var px = xP;
                var py = yP;

                while (true) {
                    var n = step(world, px, py);
                    count2[py][px] ++;
                    if (0 > n.y || n.y >= world.length) break;
                    if (0 > n.x || n.x >= world[n.y].length) break;
                    if (count2[py][px] > 4) {
                        total++;
                        break;
                    }
                    
                    world[py][px] = ".";
                    world[n.y][n.x] = n.c;
                    px = n.x;
                    py = n.y;
                }
            }
        }

        return total-1;
    }

    static function loadFile(file:String):Input {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "")
                continue;

            input.push(line.split(""));
        }
        iterator.close();
        return input;
    }
}
