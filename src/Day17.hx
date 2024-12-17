import haxe.Int64;
import utils.FilePath.FilePathImp;
using StringTools;
using Lambda;
using utils.PrimitiveTools;
import Math.*;
import utils.Utils.*;

enum abstract OpCode(Int) from Int to Int {
    var ADV;
    var BXL;
    var BST;
    var JNZ;
    var BXC;
    var OUT;
    var BDV;
    var CDV;
}

// haxe build.hxml 17
private typedef Input = {A:Int64, B:Int64, C:Int64, p:Array<Int>};
class Day17 implements Day {

    var input:Input;

    public function new() {}


    public function execute(pointer:Int, opcode:OpCode, operand:Int, output:Array<Int>) {

        var combo = switch (operand) {
            case 4: input.A.low;
            case 5: input.B.low;
            case 6: input.C.low;
            case a: a;
        }

        switch (opcode) {
            case ADV:
                input.A = input.A/(1 << combo);
            case BXL:
                input.B = input.B ^ operand;
            case BST: 
                input.B = combo % 8;
                if (input.B < 0) input.B += 8;
            case JNZ: 
                if (input.A != 0) return operand;
            case BXC: 
                input.B = input.B^input.C;
            case OUT: 
                var v = combo % 8;
                if (v < 0) v += 8;
                output.push(v);
            case BDV:
                input.B = input.A/(1 << combo);
            case CDV: 
                input.C = input.A/(1 << combo);
        }

        return pointer + 2;
    }

    public function part1() {
        var prog = input.p;
        
        var pointer = 0;
        var out = [];
        while (pointer < prog.length) {
            pointer = execute(pointer, prog[pointer], prog[pointer+1], out);
        }

        return out.join(",");
    }

    public function part2() {

        var check = [];
        var prog = input.p.copy();

        var A:Int64 = 0;

        while (!prog.empty()) {
            A = A * 8;

            var val = prog.pop();
            check.unshift(val);
            
            while (true) {
                input.A = A;
                if (part1() == check.join(",")) break;
                A++;
            }
        }
        
        return Std.string(A);
    }

    public function loadFile(file:String) {
        var input:Input = {A:0, B: 0, C: 0, p:[]};

        var f = new FilePathImp(file);
        
        var inp = f.getContent().split("\n").filter(v -> v.length != 0);
        
        var reg = ~/\d+/;
        reg.match(inp[0]);
        input.A = Int64.parseString(reg.matched(0));
        reg.match(inp[1]);
        input.B = Int64.parseString(reg.matched(0));
        reg.match(inp[2]);
        input.C = Int64.parseString(reg.matched(0));

        var aa = inp[3];
        while (reg.match(aa)) {
            input.p.push(Std.parseInt(reg.matched(0)));
            aa = reg.matchedRight();
        }

        this.input = input;
        return this;
    }
}
