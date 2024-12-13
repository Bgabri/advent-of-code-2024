using StringTools;
import Math.*;

// haxe --interp --main Day05.hx
typedef Input = {o: Array<{X:Int, Y:Int}>, u: Array<Array<Int>>};
class Day05 {
	static function main() {
		trace("solution to part 1: " + part1(loadFile("inputs/05.txt")));
		trace("solution to part 2: " + part2(loadFile("inputs/05.txt")));
	}

	static function part1(input:Input) {
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
		trace(total);
		return 0;
	}

	static function part2(input:Input) {
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
		trace(total);
		return 0;
	}

	static function loadFile(file:String):Input {
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
		return input;
	}
}
