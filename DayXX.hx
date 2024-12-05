using StringTools;
using PrimitiveTools;
using Lambda;
import Math.*;

// haxe --interp --main DayXX.hx
typedef Input = Array<Array<Int>>;
class DayXX {
	static function main() {
		trace("solution to part 1: " + part1(loadFile("inputs/XX.txt")));
		trace("solution to part 2: " + part2(loadFile("inputs/XX.txt")));
	}

	static function part1(input:Input) {
		trace(input);
		return 0;
	}

	static function part2(input:Input) {
		return 0;
	}

	static function loadFile(file:String):Input {
		var input:Input = [];
		var iterator = sys.io.File.read(file, false);

		while (!iterator.eof()) {
			var line = iterator.readLine();
			if (line == "")
				continue;

			var inp = line.split("");
			var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
			input.push(inp2);
		}
		iterator.close();
		return input;
	}
}
