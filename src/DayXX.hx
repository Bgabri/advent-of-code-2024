using StringTools;
using utils.PrimitiveTools;
using Lambda;
import Math.*;
import utils.Utils.*;

// haxe --interp --main DayXX.hx
typedef Input = Array<Array<Int>>;
class DayXX {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/XX.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/XX.txt")));
    }

    static function part1(input:Input) {
        var total = 0;
        trace(input);
        return total;
    }

    static function part2(input:Input) {
        var total = 0;
        return total;
    }

    static function loadFile(file:String):Input {
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
        return input;
    }
}
