class Utils {
    public static inline function div<T:Float>(a:T, b:T):Int {
        return Std.int(a/b);
    }

    public static inline function min<T:Float>(a:T, b:T):T {
        return (a < b) ? a : b;
    }

    public static inline function max<T:Float>(a:T, b:T):T {
        return (a > b) ? a : b;
    }

    public static inline function clamp<T:Float>(x:T, lower:T, higher:T):T {
        return min(higher, max(lower, x));
    }
}