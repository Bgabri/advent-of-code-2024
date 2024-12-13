import sys.FileSystem;
import haxe.macro.Expr;
import utils.FilePath;
using Lambda;


class Main {
    var year = 2024;
    var day:String;

    public function new(?day:Int, all:Bool = false) {
        if (day == null) day = Date.now().getDate();
        if (day < 1) day = 1;
        if (day > 25) day = 25;

        this.day = '$day';
        if (day < 10) this.day = '0$day';
        var days:Array<Day> = initDays();
        if (day > days.length) {
            Sys.println('\x1b[31mday does not exist\x1b[0m');
            Sys.exit(1);
        }
        if (all) {
            for (i in 0...days.length) {
                var strDay = '${i+1}';
                if (i < 9) strDay = '0${i+1}';
                runDay(strDay, days[i]);
                Sys.println("");
            }
        } else {
            runDay(this.day, days[day-1]);
        }
    }

    public function runDay(day:String, prog:Day) {
        var inputFile = 'inputs/${day}.txt';
        var part1 = Std.string(prog.loadFile(inputFile).part1());
        Sys.println('\x1b[2msolution to\x1b[0m day ${day} part 1: \x1b[1m\x1b[33m$part1\x1b[0m');
        
        var part2 = Std.string(prog.loadFile(inputFile).part2());
        Sys.println('\x1b[2msolution to\x1b[0m day ${day} part 2: \x1b[1m\x1b[33m$part2\x1b[0m');        
    }

    static public function loadFiles() {
        var todayExists = false;
        var day = Date.now().getDate();
        if (day > 25) day = 25;
        
        var srcPath:FilePath = "./src";
        var today = srcPath + 'Day$day.hx';
        var regex = ~/^.*\/Day\d{2}.hx$/;
        var classPaths:Array<FilePath> = [];
        for (file in srcPath.readDirectory()) {
            if (file.isDirectory()) continue;
            if (!regex.match(file)) continue;
            classPaths.push(file);
            if (file == today) todayExists = true;
        }

        if (!todayExists) {
            var regex = ~/XX/;
            var template = srcPath + "DayXX.hx";
            var s = template.getContent();    
            while (regex.match(s)) {
                s = regex.replace(s, '$day');
            }
            var todayIn:FilePath = './inputs/$day.txt';
            today.saveContent(s);
            todayIn.saveContent("");

            classPaths.push(today);
        }

        return classPaths;
    }

    static macro function initDays() {

        var ret:Array<Expr> = [];
        var files = loadFiles();

        for (file in files) {
            var name = file.file;
            var path:haxe.macro.TypePath = {pack:[], name:name};
            ret.push(macro new $path());
        }
        return macro $a{ret};
    }

    static function main() {
        var args = Sys.args();
        if (args.length > 0) {
            if (args[0] == "all") new Main(0, true);
            else new Main(Std.parseInt(args[0]));
        } else {
            new Main();
        }
    }
}