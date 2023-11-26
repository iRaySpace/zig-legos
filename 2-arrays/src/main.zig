const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const a = [3]i32{ 1, 2, 3 };
    print("length of a: {}\n", .{a.len});

    for (a) |elem| {
        print("elem: {}\n", .{elem});
    }

    const headers = [_][]const u8{ "Filesystem", "Size", "Used", "Avail", "Capacity", "iused", "ifree", "%iused", "Mounted on" };
    for (headers) |header| {
        print("header: {s}\n", .{header});
    }
}
