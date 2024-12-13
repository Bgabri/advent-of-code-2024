using StringTools;
using utils.PrimitiveTools;
using Lambda;
import Math.*;

// haxe --interp --main Day08.hx
private typedef Input = Array<Array<String>>;
class Day08 implements Day {

    var input:Input;

    public function new() {}

    public function part1() {
        var total = 0;


        var m:Map<String, Array<{x:Int, y:Int}>> = [];


        var aa:Array<Array<String>> = [];
        for (y in 0...input.length) {
            var line = input[y];
            aa.push([]);
            for (x in 0...line.length) {
                var v = line[x];
                var line = input[y];
                aa[y].push(" ");

                if (v != ".") {
                    if (m.exists(v)) {
                        m.get(v).push({x: x, y:y});
                    } else {
                        m.set(v, [{x: x, y:y}]);
                    }
                    aa[y][x] = " ";
                }
            }
        }

        var ps:Array<{x:Int, y:Int}> = [];
        for (key => val in m) {

            for (i in 0...val.length) {
                var p1 = val[i];
                for (j in i+1...val.length) {
                    var p2 = val[j];

                    var mx = p2.x - p1.x;
                    var my = p2.y - p1.y;
                    
                    var anti = {x: p1.x - mx, y: p1.y - my};
                    var anti2 = {x: p2.x + mx , y: p2.y + my};

                    if (0 <= anti.y && anti.y < aa.length && 0 <= anti.x && anti.x < aa[anti.y].length && aa[anti.y][anti.x] == " ") {
                        aa[anti.y][anti.x] = "#";
                        total++;
                    }

                    if (0 <= anti2.y && anti2.y < aa.length && 0 <= anti2.x && anti2.x < aa[anti2.y].length && aa[anti2.y][anti2.x] == " ") {
                        aa[anti2.y][anti2.x] = "#";
                        total++;
                    }
                }
            }
        }
        return total;
    }

    public function part2() {
        var total = 0;


        var m:Map<String, Array<{x:Int, y:Int}>> = [];

        var aa:Array<Array<String>> = [];

        for (y in 0...input.length) {
            aa.push([]);
            var line = input[y];
            for (x in 0...line.length) {
                aa[y].push(" ");
                var v = line[x];
                if (v != ".") {
                    if (m.exists(v)) {
                        m.get(v).push({x: x, y:y});
                    } else {
                        m.set(v, [{x: x, y:y}]);
                    }
                }
            }
        }

        var ps:Array<{x:Int, y:Int}> = [];
        for (key => val in m) {

            for (i in 0...val.length) {
                var p1 = val[i];
                for (j in i+1...val.length) {
                    var p2 = val[j];

                    var mx = p2.x - p1.x;
                    var my = p2.y - p1.y;
                    var i = 0;
                    while (true) {
                        var anti = {x: p1.x - i*mx, y: p1.y - i*my};
                        i++;

                        if (!(0 <= anti.y && anti.y < aa.length && 0 <= anti.x && anti.x < aa[anti.y].length)) {
                            break;
                        }
                        if (aa[anti.y][anti.x] == " ") {
                             aa[anti.y][anti.x] = "#";
                             total++;
                        }
                    }

                    var i = 0;
                    while (true) {
                        var anti = {x: p1.x + i*mx, y: p1.y + i*my};
                        i++;

                        if (!(0 <= anti.y && anti.y < aa.length && 0 <= anti.x && anti.x < aa[anti.y].length)) {
                            break;
                        }
                         if (aa[anti.y][anti.x] == " ") {
                             aa[anti.y][anti.x] = "#";
                             total++;
                        }
                    }
                }
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

            var inp = line.split("");
            input.push(inp);
        }
        iterator.close();
        this.input = input;
        return this;
    }
}
