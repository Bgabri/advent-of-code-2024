using StringTools;
import Math.*;

// haxe --interp --main Day02.hx
class Day02 {
	static function main() {
		trace("solution to part 1: " + part1(loadFile("inputs/02.txt")));
		trace("solution to part 2: " + part2(loadFile("inputs/02.txt")));
	}


	static function isValid(lin) {
		var inc = true;
		if (lin[1] < lin[0]) inc = false;

		var valid = true;
		for (i in 1...lin.length) {
			var diff = lin[i] - lin[i-1];

			if (diff < 0 && inc) return false;
			else if (diff > 0 && !inc) return false;

			var diff = floor(abs(diff));
			if (diff < 1 || diff > 3) return false;
			
		}
		return true;
	}
	static function part1(input:Array<Array<Int>>):Int {
		var total = 0 ;
		for (lin in input) {
			if (isValid(lin)) {
				total ++;
			}
		}
		return total;
	}

	static function part2(input:Array<Array<Int>>):Int {
		var total = 0 ;
		for (lin in input) {
			if (isValid(lin)) {
				total ++;
			} else {
				for (i in 0...lin.length) {
					var lin2 = lin.copy();
					lin2.splice(i, 1);
					if(isValid(lin2)) {
						total++;
						break;
					}
				}
			}
		}
		return total;
	}

	static function loadFile(file:String):Array<Array<Int>> {
		var input:Array<Array<Int>> = [];
		var iterator = sys.io.File.read(file, false);

		while (!iterator.eof()) {
			var line = iterator.readLine();
			if (line == "")
				continue;

			var inp = line.split(" ");
			var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
			input.push(inp2);
		}
		iterator.close();
		return input;
	}
}
