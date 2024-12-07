import haxe.Int64;
using StringTools;
using PrimitiveTools;
using Lambda;
import Math.*;

// haxe --interp --main Day07.hx
typedef Input = Array<{n:Int64, vs:Array<Int64>}>;
class Day07 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/07.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/07.txt")));
    }

    static function back(goal:Int64, current:Int64, pos:Int, eq:Array<Int64>) {
        if (current > goal) return false;
        if (pos >= eq.length) return goal == current;

        return back(goal, current*eq[pos], pos+1, eq)
            || back(goal, current+eq[pos], pos+1, eq);
    }
    static function part1(input:Input) {
        var total:Int64 = 0;
        for (line in input) {
            if (back(line.n, line.vs[0], 1, line.vs)) { 
                total += line.n;
            }
        }
        return total;
    }


    static function length(a:Int64) {
        var total:Int64 = 1;
        while (a > 0) {
            a /= 10;
            total *= 10;
        }
        return total;
        
    }

    static function concat(a:Int64, b:Int64) {
        return a*length(b) + b;
    }

    static function back2(goal:Int64, current:Int64, pos:Int, eq:Array<Int64>) {
        if (current > goal) return false;
        if (pos >= eq.length) return goal == current;

        return back2(goal, current*eq[pos], pos+1, eq)
            || back2(goal, concat(current, eq[pos]), pos+1, eq)
            || back2(goal, current+eq[pos], pos+1, eq);
    }
    
    static function part2(input:Input) {
        var total:Int64 = 0;
        for (line in input) {
            if (back2(line.n, line.vs[0], 1, line.vs)) { 
                total += line.n;
            }
        }
        return total;
    }


    static function loadFile(file:String):Input {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var line = iterator.readLine();
            var aa = line.split(": ");
            var inp = aa[1].split(" ");
            var inp2:Array<Int64> = inp.map(v -> Int64.parseString(v));
            input.push({n: Int64.parseString(aa[0]), vs: inp2});
        }
        iterator.close();
        return input;
    }
}
