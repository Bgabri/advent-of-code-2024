using StringTools;
import Math.*;

// haxe build.hxml 04
private typedef Input = Array<String>;
class Day04 implements Day {

    var input:Input;

    public function new() {}

    static function find(hay:Array<String>, needle:String, pos:{x:Int, y:Int}, inc:{x:Int, y:Int}) {
        for (i in 0...needle.length) {
            if ( 0 > pos.y || pos.y >= hay.length) return false;
            if ( 0 > pos.x || pos.x >= hay[pos.y].length) return false;
            if (hay[pos.y].charAt(pos.x) != needle.charAt(i)) return false;
            pos.x += inc.x;
            pos.y += inc.y;
        }
           return true;
    }

    public function part1() {
        var total = 0;
        for (y in 0...input.length) {
            var line = input[y];
            for (x in 0...line.length) {
                if (find(input, "XMAS", {x: x, y: y}, {x: 1, y: 0})) total++;
                if (find(input, "XMAS", {x: x, y: y}, {x: 0, y: 1})) total++;
                if (find(input, "XMAS", {x: x, y: y}, {x:-1, y: 0})) total++;
                if (find(input, "XMAS", {x: x, y: y}, {x: 0, y:-1})) total++;

                if (find(input, "XMAS", {x: x, y: y}, {x: 1, y: 1})) total++;
                if (find(input, "XMAS", {x: x, y: y}, {x:-1, y:-1})) total++;
                if (find(input, "XMAS", {x: x, y: y}, {x: 1, y:-1})) total++;
                if (find(input, "XMAS", {x: x, y: y}, {x:-1, y: 1})) total++;
            }
        }
        return total;
    }

    public function part2() {
        var total = 0;
        for (y in 0...input.length) {
            var line = input[y];
            for (x in 0...line.length) {
                if (find(input, "MAS", {x: x, y: y}, {x: 1, y: 1})) {
                    if (find(input, "MAS", {x: x, y: y+2}, {x: 1, y: -1}) || find(input, "MAS", {x: x+2, y: y}, {x: -1, y: 1}) ) {
                        total++;
                    }
                }
                if (find(input, "MAS", {x: x, y: y}, {x: -1, y: -1})) {
                    if (find(input, "MAS", {x: x, y: y-2}, {x: -1, y: 1}) || find(input, "MAS", {x: x-2, y: y}, {x: 1, y: -1}) ) {
                        total++;
                    }
                }
                // if (find(input, "MAS", {x: x, y: y}, {x:-1, y:-1})) {
                //     total++;
                // }
                // if (find(input, "MAS", {x: x, y: y}, {x: 1, y:-1})) {
                //     total++;
                // }
                // if (find(input, "MAS", {x: x, y: y}, {x:-1, y: 1})) {
                //     total++;
                // }
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
