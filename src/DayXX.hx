using StringTools;
using Lambda;
using utils.PrimitiveTools;
import utils.Utils.*;
import Math.*;

// haxe build.hxml XX
private typedef Input = Array<Array<Int>>;
class DayXX implements Day {

    var input:Input;

    public function new() {}

    public function part1() {
        var total = 0;
        trace(input);
        return total;
    }

    public function part2() {
        var total = 0;
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
