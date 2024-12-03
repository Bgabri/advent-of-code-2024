using StringTools;
import Math.*;

// haxe --interp --main Day03.hx
typedef Input = String;
class Day03 {
	static function main() {
		trace("solution to part 1: " + part1(loadFile("inputs/03.txt")));
		trace("solution to part 2: " + part2(loadFile("inputs/03.txt")));
	}

	static function part1(input:Array<Input>) {
		var total = 0;

		var reg = ~/mul\(([0-9]+),([0-9]+)\)/;
		for (line in input) {
			while (reg.match(line)) {
				var a = Std.parseInt(reg.matched(1));
				var b = Std.parseInt(reg.matched(2));

				line = reg.matchedRight();
				total += a*b;
			}
		}

		return total;
	}

	static function part2(input:Array<Input>) {
		var total = 0;

		var reg = ~/(mul\(([0-9]+),([0-9]+)\))|(do\(\))|(don't\(\))/;

		var flag = true;
		for (line in input) {
			while (reg.match(line)) {
				var a = Std.parseInt(reg.matched(2));
				var b = Std.parseInt(reg.matched(3));

				if (reg.matched(4) != null) flag = true;
				else if (reg.matched(5) != null) flag = false;
				else if (flag) total += a*b;

				line = reg.matchedRight();
			}
		}

		return total;
	}

	static function loadFile(file:String):Array<Input> {
		var input:Array<Input> = [];
		var iterator = sys.io.File.read(file, false);

		while (!iterator.eof()) {
			var line = iterator.readLine();
			if (line == "")
				continue;

			input.push(line);
		}
		iterator.close();
		return input;
	}
}
