using StringTools;
import Math.*;

// haxe --interp --main Day04.hx
typedef Input = String;
class Day04 {
	static function main() {
		trace("solution to part 1: " + part1(loadFile("inputs/04.txt")));
		trace("solution to part 2: " + part2(loadFile("inputs/04.txt")));
	}

	static function find(hay:Array<String>, needle:String, pos:{x:Int, y:Int}, inc:{x:Int, y:Int}) {
	    for (i in 0...needle.length) {
			if ( 0 > pos.y || pos.y >= hay.length) return false;
			if ( 0 > pos.x || pos.x >= hay[pos.y].length) return false;
			if (hay[pos.y].charAt(pos.x) != needle.charAt(i)) return false;
			pos.x += inc.x;
			pos.y += inc.y;
		}
	   	return true;
	}

	static function part1(input:Array<Input>) {
	    var total = 0;
	    for (y in 0...input.length) {
			var line = input[y];
			for (x in 0...line.length) {
	            if (find(input, "XMAS", {x: x, y: y}, {x: 1, y: 0})) total++;
	            if (find(input, "XMAS", {x: x, y: y}, {x: 0, y: 1})) total++;
	            if (find(input, "XMAS", {x: x, y: y}, {x:-1, y: 0})) total++;
	            if (find(input, "XMAS", {x: x, y: y}, {x: 0, y:-1})) total++;

	            if (find(input, "XMAS", {x: x, y: y}, {x: 1, y: 1})) total++;
	            if (find(input, "XMAS", {x: x, y: y}, {x:-1, y:-1})) total++;
	            if (find(input, "XMAS", {x: x, y: y}, {x: 1, y:-1})) total++;
	            if (find(input, "XMAS", {x: x, y: y}, {x:-1, y: 1})) total++;
			}
		}
		return total;
	}

	static function part2(input:Array<Input>) {
		var total = 0;
	    for (y in 0...input.length) {
			var line = input[y];
			for (x in 0...line.length) {
				if (find(input, "MAS", {x: x, y: y}, {x: 1, y: 1})) {
					if (find(input, "MAS", {x: x, y: y+2}, {x: 1, y: -1}) || find(input, "MAS", {x: x+2, y: y}, {x: -1, y: 1}) ) {
						total++;
					}
				}
				if (find(input, "MAS", {x: x, y: y}, {x: -1, y: -1})) {
					if (find(input, "MAS", {x: x, y: y-2}, {x: -1, y: 1}) || find(input, "MAS", {x: x-2, y: y}, {x: 1, y: -1}) ) {
						total++;
					}
				}
	            // if (find(input, "MAS", {x: x, y: y}, {x:-1, y:-1})) {
				// 	total++;
				// }
	            // if (find(input, "MAS", {x: x, y: y}, {x: 1, y:-1})) {
				// 	total++;
				// }
	            // if (find(input, "MAS", {x: x, y: y}, {x:-1, y: 1})) {
				// 	total++;
				// }
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
