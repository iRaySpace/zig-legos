const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const header = "Filesystem\nNTFS\nXFS\nFAT32";
    var lines = std.mem.tokenize(u8, header, "\n");
    while (lines.next()) |line| {
        print("{s}\n", .{line});
    }
}
