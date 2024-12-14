using StringTools;
import Math.*;

// haxe build.hxml 03
private typedef Input = Array<String>;
class Day03 implements Day {

    var input:Input;

    public function new() {}

    public function part1() {
        var total = 0;

        var reg = ~/mul\(([0-9]+),([0-9]+)\)/;
        for (line in input) {
            while (reg.match(line)) {
                var a = Std.parseInt(reg.matched(1));
                var b = Std.parseInt(reg.matched(2));

                line = reg.matchedRight();
                total += a*b;
            }
        }

        return total;
    }

    public function part2() {
        var total = 0;

        var reg = ~/(mul\(([0-9]+),([0-9]+)\))|(do\(\))|(don't\(\))/;

        var flag = true;
        for (line in input) {
            while (reg.match(line)) {
                var a = Std.parseInt(reg.matched(2));
                var b = Std.parseInt(reg.matched(3));

                if (reg.matched(4) != null) flag = true;
                else if (reg.matched(5) != null) flag = false;
                else if (flag) total += a*b;

                line = reg.matchedRight();
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

            input.push(line);
        }
        iterator.close();
        this.input = input;
        return this;
    }
}
