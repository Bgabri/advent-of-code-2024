
class PrimitiveTools {

    public static inline function repeat(str:String, length:Int):String {
        var s = "";
        while (s.length < length) s += str;
        return s.substr(0, length);
    }

    public static inline function insert(
        str:String, index:Int, c:String
    ):String {
        return str.substring(0, index) + c + str.substring(index);
    }

    public static inline function replace(
        str:String, index:Int, c:String
    ):String {
        return str.substring(0, index) + c + str.substring(index+c.length);
    }

    public static inline function remove(str:String, index:Int):String {
        return str.substring(0, index) + str.substring(index+1);
    }

    public static inline function flatten(arr:Array<String>):String {
        var s = "";
        for (v in arr) s += v;
        return s;
    }

    public static function max<T:Int>(arr:Array<T>):T {
        var maxV:T = arr[0];
        for (v in arr) {
            if (maxV < v) maxV = v;
        }
        return maxV;
    }

    public static function min<T:Int>(arr:Array<T>):T {
        var minV:T = arr[0];
        for (v in arr) {
            if (minV > v) minV = v;
        }
        return minV;
    }

    public static function any<T>(arr:Array<T>, f:T -> Bool):Bool {
        for (v in arr) if (f(v)) return true;
        return false;
    }

    public static function all<T>(arr:Array<T>, f:T -> Bool):Bool {
        for (v in arr) if (!f(v)) return false;
        return true;
    }

    public static function clone<T>(a:Array<Array<T>>):Array<Array<T>> {
        var n:Array<Array<T>> = [];
        for (y in 0...a.length) {
            n.push([]);
            for (x in 0...a[y].length) {
                n[y].push(a[y][x]);
            }
        }
        return n;
    }
}