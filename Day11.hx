import haxe.Int64;
using StringTools;
using PrimitiveTools;
using Lambda;
import Math.*;
import Utils.*;

// haxe --interp --main Day11.hx
typedef Input = Map<Int64, Int64>;
class Day11 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/11.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/11.txt")));
    }

    static function numDigits(N:Int64) {
        var n = 0;
        while (N > 0) {
            N = N/10;
            n++;
        }
        return n;
    }

    static function add(m:Input, i, n) {
        if (m.exists(i)) m[i] += n;
        else m[i] = n;
    }

    static function blink(rocks:Input) {
        var next:Input = [];
        for (rock => n in rocks) {
            if (n < 0) trace(n);
            var digits = numDigits(rock);
            if (rock == 0){
                if (next.exists(1)) next[1] += n;
                else next[1] = n;
            } else if (digits%2 == 0) {
                digits = floor(pow(10, digits/2));
                var left = rock/digits;
                var right = rock%digits;

                add(next, left, n);
                add(next, right, n);

            }
            else add(next, rock*2024, n);
        }
        return next;
    }

    static function part1(input:Input) {
        for (i in 0...25) {
            input = blink(input);
        }

        return input.fold((a, b) -> a+b, 0);
    }

    static function part2(input:Input) {
        for (i in 0...75) {
            input = blink(input);
        }

        return input.fold((a, b) -> a+b, 0);
    }

    static function loadFile(file:String):Input {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        var line = iterator.readLine();

        var inp = line.split(" ");
        var inp = inp.map(v -> Std.parseInt(v));
        for (v in inp) {
            add(input, v, 1);
        }
        iterator.close();
        return input;
    }
}
