import haxe.Int64;
using StringTools;
using PrimitiveTools;
using Lambda;

import Math.*;

// haxe --interp --main Day09.hx
typedef Input = Array<Int>;

class Day09 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/09.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/09.txt")));
    }

    static function part1(lengths:Input) {
        var memoryLength:Input = [];
        var memoryValues:Input = [];

        var headValue = 0;
        var tailValue = floor(lengths.length/2) +1;
        var leftOverLength = 0;
        while (!lengths.empty()) {
            var headLength = lengths.shift();
            memoryLength.push(headLength);
            memoryValues.push(headValue);
            
            var freeLength = lengths.shift();
            while (freeLength > 0) {
                if (leftOverLength > 0) {
                    if (freeLength < leftOverLength) {
                        memoryLength.push(freeLength);
                        memoryValues.push(tailValue);
                        leftOverLength -= freeLength;
                        freeLength = 0;
                    } else {
                        memoryLength.push(leftOverLength);
                        memoryValues.push(tailValue);
                        freeLength -= leftOverLength; 
                        leftOverLength = 0;
                    }
                } else {
                    leftOverLength = lengths.pop();
                    lengths.pop(); // free
                    tailValue --;
                }
            }
            headValue ++;
        }
        
        if (leftOverLength != 0) {
            memoryLength.push(leftOverLength);
            memoryValues.push(tailValue);
        }
        

        var total:Int64 = 0;

        var p:Int64 = 0;
        for (i in 0...memoryLength.length) {
            for (j in 0...memoryLength[i]) {
                total += memoryValues[i] *p;
                p++;
            }
        }

        return total;
    }

    static function part2(lengths:Input) {
        var memoryLength:Input = [for (v in lengths) v];
        var memoryValues:Input = [for (i in 0...lengths.length) if (i%2 == 0) floor(i/2) else -1];
        var memoryOffset:Input = [for (i in 0...lengths.length) if (i%2 == 0) 2 else 0];
        
        var index = lengths.length - 1;
        while (index >= 0) {
            var currentLength = memoryLength[index];
            var currentValue = memoryValues[index];
            for (i in 0...index) {
                var v = memoryValues[i];
                var l = memoryLength[i];
                if (v == -1) {
                    if (currentLength == l) {
                        memoryValues[index] = -1;
                        memoryValues[i] = currentValue;
                        memoryLength[i] = currentLength;
                        break;
                    } else if (currentLength < l) {
                        memoryValues[index] = -1;
                        memoryValues[i] = currentValue;
                        memoryLength[i] = currentLength;
                        memoryLength.insert(i+1, l - currentLength);
                        memoryValues.insert(i+1, -1);
                        memoryOffset[i+1]++;
                        memoryOffset.insert(i+1, 0);
                        index++;
                        break;
                    }
                }
            }
            index -= memoryOffset[index];
        }

        var total:Int64 = 0;
        var p = 0;
        for (i in 0...memoryLength.length) {
            if (memoryValues[i] == -1) {
                p+=memoryLength[i];
            } else {
                for (j in 0...memoryLength[i]) {
                    total += memoryValues[i] * p;
                    p++;
                }
            }
        }

        return total;
    }

    static function loadFile(file:String):Input {
        var input:Input = [];
        var iterator = sys.io.File.read(file, false);

        var line = iterator.readLine();

        var inp = line.split("");
        input = inp.map(v -> Std.parseInt(v));
        iterator.close();
        return input;
    }
}
