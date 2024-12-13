import sys.FileSystem;
import haxe.macro.Expr;
import utils.FilePath;
using Lambda;


class Main {
    var year = 2024;
    var day:String;

    public function new(?day:Int) {
        if (day == null) day = Date.now().getDate();
        if (day < 1) day = 1;
        if (day > 25) day = 25;
        this.day = '$day';
        if (day < 10) this.day = '0$day';
        // var files = loadFiles();

        var ds = days();

    }

    static function loadFiles() {
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

    static function main() {
        var args = Sys.args();
        if (args.length > 0) {
            new Main(Std.parseInt(args[0]));
        } else {
            new Main();
        }
    }

    static macro function days() {

        var ret:Array<Expr> = [];
        var files = loadFiles();
        for (file in files) {
            var name = file.file;
            var path:haxe.macro.TypePath = {pack:[], name:name};
            ret.push(macro new $path());
        }
        return macro $a{ret};
    }
}