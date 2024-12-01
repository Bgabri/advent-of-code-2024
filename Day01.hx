import Math.*;

using StringTools; // haxe --interp --main Day01.hx

class Day01 {
	static function main() {
		trace("solution to part 1: " + part1(loadFile("inputs/01.txt")));
		trace("solution to part 2: " + part2(loadFile("inputs/01.txt")));
	}

	static function part1(input:Array<Array<Int>>):Int {
		var left = [];
		var right = [];
		for (inp in input) {
			left.push(inp[0]);
			right.push(inp[1]);
		}

		left.sort((a, b) -> a - b);
		right.sort((a, b) -> a - b);

		var total = 0;
		for (i in 0...left.length) {
			total += floor(abs(left[i] - right[i]));
		}

		return total;
	}

	static function part2(input:Array<Array<Int>>):Int {
		var left = [];
		var right = [];
		for (inp in input) {
			left.push(inp[0]);
			right.push(inp[1]);
		}

		left.sort((a, b) -> a - b);
		right.sort((a, b) -> a - b);

		var total = 0;
		for (l in left) {
			var reps = 0;
			for (r in right) {
				if (r > l)
					break;
				if (r == l)
					reps++;
			}

			total += reps * l;
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
			var inp = line.split("   ");
			var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
			input.push(inp2);
		}
		iterator.close();
		return input;
	}
}
