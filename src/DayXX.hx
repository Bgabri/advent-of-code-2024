import utils.FilePath.FilePathImp;
using StringTools;
using Lambda;
using utils.PrimitiveTools;
import Math.*;
import utils.Utils.*;

// haxe build.hxml XX
private typedef Input = Array<Array<Int>>;
class DayXX implements Day {

    var input:Input;

    public function new() {}

    public function part1() {
        var total = 0;
        input.prettyPrint();
        return total;
    }

    public function part2() {
        var total = 0;
        return total;
    }

    public function loadFile(file:String) {
        var input:Input = [];
        var f = new FilePathImp(file);
        
        var inp = f.getContent();

        // input = inp.split("\n").map((line) -> line.split(""));
        input = inp.split("\n").map((line) -> line.split("").map(Std.parseInt));
        input = input.filter(v -> v.length != 0);

        this.input = input;
        return this;
    }
}
