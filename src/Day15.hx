using StringTools;
using Lambda;
using utils.PrimitiveTools;
import Math.*;
import utils.Utils.*;

// haxe build.hxml 15
private typedef Input = {map:Array<String>, moves:String};
class Day15 implements Day {

    var input:Input;

    public function new() {}

    function push(px:Int, py:Int, dx:Int, dy:Int, world:Array<String>) {
        var nx = px+dx;
        var ny = py+dy;
        switch world[ny].charAt(nx) {
            case "#": return false;
            case "O": 
                if (push(nx, ny, dx, dy, world)) {
                    world[py] = world[py].replace(px, ".");
                    world[ny] = world[ny].replace(nx,"O");

                    return true;
                }

                return false;
            case ".": 
                world[py] = world[py].replace(px, ".");
                world[ny] = world[ny].replace(nx,"O");
                return true;
        }

        return false;
    }

    function step(rx:Int, ry:Int, dx:Int, dy:Int, world:Array<String>) {
        
        var nx = rx+dx;
        var ny = ry+dy;
        switch world[ny].charAt(nx) {
            case "#":
                return {x:rx, y:ry};
            case ".":
                return {x:nx, y:ny};
            case "O":
                if (push(nx, ny, dx, dy, world)) {
                    return {x:nx, y:ny};
                }
                return {x:rx, y:ry};

            case _:
        }
        throw "HUH";
        return {x:nx, y:ny};
    }

    public function part1() {
        var total = 0;
        var map = input.map;
        var rx = 0;
        var ry = 0;

        for (y in 0...map.length) {
            for (x in 0...map[y].length) {
                if (map[y].charAt(x) == "@") {
                    rx = x;
                    ry = y;
                }
            }
        }

        map[ry] = map[ry].replace(rx, ".");
        for (steps in input.moves) {
            var dy = 0;
            var dx = 0;
            switch steps {
                case "^".code: dy = -1;
                case ">".code: dx = 1;
                case "v".code: dy = 1;
                case "<".code: dx = -1;
            }
            var p = step(rx, ry, dx, dy, map);
            rx = p.x;
            ry = p.y;
            
        }
        
        for (y in 0...map.length) {
            for (x in 0...map[y].length) {
                if (map[y].charAt(x) == "O") {
                    total += 100*y;
                    total += x;
                }
            }
        }

        return total;
    }

    function canMove(side:String, px:Int, py:Int, dx:Int, dy:Int, world:Array<String>) {
        var nx = px+dx;
        var ny = py+dy;
        switch world[ny].charAt(nx) {
            case "#": return false;
            case "[":
                if (dx == 0) {
                    return canMove("[", nx, ny, dx, dy, world) && canMove("]", nx+1, ny, dx, dy, world);
                }
                return canMove("]", nx, ny, dx, dy, world);

            case "]":
                if (dx == 0) {

                    return canMove("[", nx-1, ny, dx, dy, world) && canMove("]", nx, ny, dx, dy, world);
                }
                return canMove("]", nx, ny, dx, dy, world);
            case ".": 
                return true;
        }
        return false;
    }

    function push2(side:String, px:Int, py:Int, dx:Int, dy:Int, world:Array<String>) {
        var nx = px+dx;
        var ny = py+dy;
        switch world[ny].charAt(nx) {
            case "#": return false;
            case "[":
                if (dx == 0) {
                    push2("]", nx+1, ny, dx, dy, world);
                }
                push2("[", nx, ny, dx, dy, world);
                world[ny] = world[ny].replace(nx, world[py].charAt(px));
                world[py] = world[py].replace(px, ".");
                return true;
            case "]":
                if (dx == 0) {
                    push2("[", nx-1, ny, dx, dy, world);
                }
                push2("]", nx, ny, dx, dy, world);
                world[ny] = world[ny].replace(nx, world[py].charAt(px));
                world[py] = world[py].replace(px, ".");
                return true;
            case ".": 
                world[ny] = world[ny].replace(nx, world[py].charAt(px));
                world[py] = world[py].replace(px, ".");
                return true;
        }
        return false;
    }

    function step2(rx:Int, ry:Int, dx:Int, dy:Int, world:Array<String>) {
        var nx = rx+dx;
        var ny = ry+dy;
        
        switch world[ny].charAt(nx) {
            case "#":
                return {x:rx, y:ry};
            case ".":
                return {x:nx, y:ny};
            case "[":
                if (dx == 0) {
                    if (canMove("[", nx, ny, dx, dy, world) && canMove("]", nx+1, ny, dx, dy, world)) {
                        push2("[", nx, ny, dx, dy, world);
                        push2("]", nx+1, ny, dx, dy, world);
                        return {x:nx, y:ny};

                    }
                } else 
                if (canMove("[", nx, ny, dx, dy, world)) {
                    push2("[", nx, ny, dx, dy, world);
                    return {x:nx, y:ny};
                }
                return {x:rx, y:ry};
            case "]":
                if (dx == 0) {
                    if (canMove("[", nx, ny, dx, dy, world) && canMove("]", nx-1, ny, dx, dy, world)) {
                        push2("[", nx, ny, dx, dy, world);
                        push2("]", nx-1, ny, dx, dy, world);
                        return {x:nx, y:ny};
                    }
                } else  if (canMove("[", nx, ny, dx, dy, world)) {
                    push2("[", nx, ny, dx, dy, world);
                    return {x:nx, y:ny};
                }
                return {x:rx, y:ry};
            case c:
                throw 'HUH $c';
        }
        return {x:nx, y:ny};
    }


    public function part2() {
        var map:Array<String> = [];
        var rx = 0;
        var ry = 0;
        
        
        for (y in 0...input.map.length) {
            var line = "";
            for (x in 0...input.map[y].length) {
                switch input.map[y].charAt(x) {
                    case ".": line += "..";
                    case "@": line += "@.";
                    case "#": line += "##";
                    case "O": line += "[]";
                }
            }
            map.push(line);
        }

        for (y in 0...map.length) {
            for (x in 0...map[y].length) {
                if (map[y].charAt(x) == "@") {
                    rx = x;
                    ry = y;
                }
            }
        }

        map[ry] = map[ry].replace(rx, ".");

        for (steps in input.moves) {
            var dy = 0;
            var dx = 0;
            switch steps {
                case "^".code: dy = -1;
                case ">".code: dx = 1;
                case "v".code: dy = 1;
                case "<".code: dx = -1;
            }
            var p = step2(rx, ry, dx, dy, map);
            rx = p.x;
            ry = p.y;
        }


        var total:Float = 0;

        for (y in 0...map.length) {
            for (x in 0...map[y].length) {
                if (map[y].charAt(x) == "[") {
                    total += 100*y;
                    total += x;
                }
            }
        }

        return total;
    }

    public function loadFile(file:String) {
        var input:Input = {map:[], moves:""};
        var iterator = sys.io.File.read(file, false);

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "") break;

            input.map.push(line);
        }

        while (!iterator.eof()) {
            var line = iterator.readLine();
            if (line == "") break;

            input.moves += line;
        }

        iterator.close();
        this.input = input;
        return this;
    }
}
