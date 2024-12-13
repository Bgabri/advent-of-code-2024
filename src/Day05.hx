using StringTools;
import Math.*;

// haxe --interp --main Day05.hx
private typedef Input = {o: Array<{X:Int, Y:Int}>, u: Array<Array<Int>>};
class Day05 implements Day {

    var input:Input;

    public function new() {}

    public function part1() {
        var total = 0;
        var updates = input.u;
        var ords = input.o;
        for (update in updates) {
            var aa = update.copy();
            update.sort(
                (a, b) -> {
                    if (ords.filter((o)-> o.X == a &&o.Y == b).length > 0) {
                        return -1;
                    }
                    return 1;
                }
            );
            var valid = true;
            for (i in 0...update.length) {
                if (update[i] != aa[i]) valid = false;
            }
            if (valid) { 
                total += update[floor(update.length/2)];
            }
        }
        return total;
    }

    public function part2() {
        var total = 0;
        var updates = input.u;
        var ords = input.o;
        for (update in updates) {
            var aa = update.copy();
            update.sort(
                (a, b) -> {
                    if (ords.filter((o)-> o.X == a &&o.Y == b).length > 0) {
                        return -1;
                    }
                    return 1;
                }
            );
            var valid = true;
            for (i in 0...update.length) {
                if (update[i] != aa[i]) valid = false;
            }
            if (!valid) { 
                total += update[floor(update.length/2)];
            }
        }
        return total;
    }

    public function loadFile(file:String) {
        var input:Input = {o:[], u:[]};
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "")
                break;

            var inp = line.split("|");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.o.push({X:inp2[0], Y:inp2[1]});
        }

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "")
                break;

            var inp = line.split(",");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.u.push(inp2);
        }

        iterator.close();
        this.input = input;
        return this;
    }
}
