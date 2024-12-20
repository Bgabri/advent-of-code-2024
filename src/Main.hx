
/**
 * int64
 * matrices
 * vectors
 * separate utils lib
 */


import haxe.Timer;
import sys.FileSystem;
import haxe.macro.Expr;
import utils.FilePath;
using Lambda;
using utils.Utils;
using utils.PrimitiveTools;


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

    function runDay(day:String, prog:Day) {
        var inputFile:FilePath = 'inputs/${day}.txt';
        if (!inputFile.exists()) {
            Main.downloadInput(Std.parseInt(day), inputFile);
        }


        Sys.println("─".repeat(15));

        var before = Timer.stamp();
        var part1 = prog.loadFile(inputFile).part1();
        var after = Timer.stamp();
        
        Sys.println('day ${day} part 1: \x1b[1m\x1b[33m$part1\x1b[0m');
        printTiming(before, after);

        Sys.println("─".repeat(15));
    
        var before = Timer.stamp();
        var part2 = prog.loadFile(inputFile).part2();
        var after = Timer.stamp();

        Sys.println('day ${day} part 2: \x1b[1m\x1b[33m$part2\x1b[0m');
        printTiming(before, after);
        
        Sys.println("─".repeat(15));
    }
    
    function printTiming(before:Float, after:Float) {
        var diff = after - before;
        diff = Math.round(diff*100)/100;
        var colour = "\x1b[2m";
        if (diff >= 10) {
            colour = "\x1b[1m\x1b[31m"; // bold red
        } else if (diff >= 1) {
            colour = "\x1b[31m"; // red
        } else if (diff > 0.1) {
            colour = "\x1b[33m"; // yellow
        }
        Sys.println(colour + '[${diff}s]\x1b[0m');
    }

    static public function loadFiles() {
        var todayExists = false;
        var day = Date.now().getDate();
        if (day > 25) day = 25;
        var strDay = '${day}';
        if (day < 10) strDay = '0$day';
        var srcPath:FilePath = "./src";
        var today = srcPath + 'Day$strDay.hx';
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
                s = regex.replace(s, strDay);
            }

            var todayIn:FilePath = './inputs/$strDay.txt';
            today.saveContent(s);
            todayIn.saveContent(" ");
            downloadInput(day, todayIn);

            classPaths.push(today);
        }

        return classPaths;
    }

    static public function downloadInput(day:Int, file:FilePath) {
    
        Sys.println('downloading day $day input');
        var userAgent:FilePath = "./user-agent.txt";
        var cookie:FilePath = "./cookie.txt";

        var http = new sys.Http('https://adventofcode.com/2024/day/$day/input');
        http.addHeader("User-Agent", userAgent.getContent());
        http.addHeader("Cookie", cookie.getContent());
        http.onData = data -> {
            data = data.remove(data.length-1); // remove new line
            file.saveContent(data);
        }
        http.onError = error -> throw 'HTTP error: $error';
        http.request();
        Sys.println('\x1b[A\x1b[2Kdownloaded day $day input');
        trace("hi");

        
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