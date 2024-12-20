import haxe.Int64;
import utils.FilePath.FilePathImp;
using StringTools;
using Lambda;
using utils.PrimitiveTools;
import Math.*;
import utils.Utils.*;

// haxe build.hxml 19
private typedef Input = {t:Array<String>, p: Array<String>};
class Day19 implements Day {

    var input:Input;

    public function new() {}

    function matchPatten(pattern:String, towels:Array<String>) {
        if (pattern.length == 0) return [];
        var matched = [];
        for (p in towels) {
            if (pattern.startsWith(p)) {
                var rest = matchPatten(pattern.substr(p.length), towels);
                if (pattern == p + rest.join("")) {
                    rest.unshift(p);
                    return rest;
                }
            }
        }
        return matched;
    }

    public function part1() {
        var total = 0;
        for (p in input.p) {
            if (matchPatten(p, input.t).length != 0) {
                total++;
            }
        }
        return total;
    }

    var memo:Map<String, Int64> = [];

    function countPattens(pattern:String, ps:Array<String>,  towels:Array<String>):Int64 {
        if (pattern.length == 0) return 1;

        if (memo.exists(pattern)) return memo[pattern];

        var matched:Int64 = 0;
        for (p in towels) {
            if (pattern.startsWith(p)) {
                var psn = ps.copy();
                psn.push(p);

                var total = countPattens(pattern.substr(p.length), psn, towels);
                matched += total;
            }
        }
        memo[pattern] = matched;
        return matched;
    }

    public function part2() {
        var total:Int64 = 0;
        var i = 0;
        for (p in input.p) {
            total += countPattens(p, [], input.t);
            memo = [];
            i++;
        }
        return Std.string(total);
    }


    public function loadFile(file:String) {
        var input:Input = {t: [], p: []};
        var f = new FilePathImp(file);
        
        var inp = f.getContent();
        var inp = inp.split("\n");

        
        input.t = inp[0].split(", ");
        
        for (i in 1...inp.length) {
            if (inp[i].length == 0) continue;
            input.p.push (inp[i]);
        }

        this.input = input;
        return this;
    }
}
