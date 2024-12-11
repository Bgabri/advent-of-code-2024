import haxe.Int64;
using StringTools;
using PrimitiveTools;
using Lambda;
import Math.*;
import Utils.*;

// haxe --interp --main Day11.hx
typedef Input = Array<Int>;
class Day11 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/11.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/11.txt")));
    }

    static function blink(constant:Int, rocks:Input) {
        var next:Input = [];
        for (rock in rocks) {
            var digits = floor(log(rock)/log(10))+1;
            // if (rock < 5) constant += 4;
            // if (floor(log(rock)/log(2)) == log(rock)/log(2)) {
            //     constant += floor(log(rock)/log(2));
            if (rock == 0) next.push(1);
            // } 
            else if (digits%2 == 0) {
                digits = floor(pow(10, digits/2));
                var left = floor(rock/digits);
                var right = rock%digits;
                next.push(left);
                next.push(right);
            }
            else next.push(rock*2024);
        }
        return {c:constant, n:next};
    }

    static function part1(input:Input) {
        var constant = 0;
        for (i in 0...25) {
            var aa = blink(constant, input);
            input = aa.n;
            constant = aa.c;
            // trace(constant, input);
            // trace(i, input.length);
        }

        return input.length + constant;
    }

    static function part2(input:Input) {
        // for (i in 0...75) {
        //     input = blink(input);
        // }

        // return input.length;
        return 0;
    }

    static function loadFile(file:String):Input {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        var line = iterator.readLine();

        var inp = line.split(" ");
        input = inp.map(v -> Std.parseInt(v));
        iterator.close();
        return input;
    }
}
