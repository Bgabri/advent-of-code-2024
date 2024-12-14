import Math.*;

using StringTools;

// haxe build.hxml 01
private typedef Input = Array<Array<Int>>;
class Day01 implements Day {
    
    var input:Input;
    
    public function new() {}

    public function part1() {
        var left = [];
        var right = [];
        for (inp in input) {
            left.push(inp[0]);
            right.push(inp[1]);
        }

        left.sort((a, b) -> a - b);
        right.sort((a, b) -> a - b);

        var total = 0;
        for (i in 0...left.length) {
            total += floor(abs(left[i] - right[i]));
        }

        return total;
    }

    public function part2() {
        var left = [];
        var right = [];
        for (inp in input) {
            left.push(inp[0]);
            right.push(inp[1]);
        }

        left.sort((a, b) -> a - b);
        right.sort((a, b) -> a - b);

        var total = 0;
        for (l in left) {
            var reps = 0;
            for (r in right) {
                if (r > l)
                    break;
                if (r == l)
                    reps++;
            }

            total += reps * l;
        }

        return total;
    }

    public function loadFile(file:String) {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "")
                continue;
            var inp = line.split("   ");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp2);
        }
        iterator.close();
        this.input = input;
        return this;
    }
}
