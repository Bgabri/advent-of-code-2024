using StringTools;
import Math.*;

// haxe --interp --main Dayxx.hx
typedef Input = Array<Int>;
class DayXX {
	static function main() {
		trace("solution to part 1: " + part1(loadFile("inputs/XX.txt")));
		trace("solution to part 2: " + part2(loadFile("inputs/XX.txt")));
	}

	static function part1(input:Array<Input>) {
		trace(input);
		return 0;
	}

	static function part2(input:Array<Input>) {
		return 0;
	}

	static function loadFile(file:String):Array<Input> {
		var input:Array<Input> = [];
		var iterator = sys.io.File.read(file, false);

		while (!iterator.eof()) {
			var line = iterator.readLine();
			if (line == "")
				continue;

			var inp = line.split("");
			var inp2:Input = inp.map(v -> Std.parseInt(v));
			input.push(inp2);
		}
		iterator.close();
		return input;
	}
}
