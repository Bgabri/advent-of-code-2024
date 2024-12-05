class PrimitiveTools {

    public static inline function repeat(str:String, n:Int) {
        var s = "";
        for (_ in 0...n) s += str;
        return s;
    }

    public static function max<T:Int>(arr:Array<T>) {
        var maxV:T = arr[0];
        for (v in arr) {
            if (maxV < v) maxV = v;
        }
        return maxV;
    }

    public static function min<T:Int>(arr:Array<T>) {
        var minV:T = arr[0];
        for (v in arr) {
            if (minV > v) minV = v;
        }
        return minV;
    }

    public static function any<T>(arr:Array<T>, f:T -> Bool) {
        for (v in arr) if (f(v)) return true;
        return false;
    }

    public static function all<T>(arr:Array<T>, f:T -> Bool) {
        for (v in arr) if (!f(v)) return false;
        return true;
    }
}