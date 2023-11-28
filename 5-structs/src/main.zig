const std = @import("std");
const print = std.debug.print;

const Disk = struct {
    file_system: []const u8,
    mounted_on: []const u8,
};

pub fn main() !void {
    const root_disk = Disk{
        .file_system = "/dev/disk2s3s1",
        .mounted_on = "/",
    };
    print("{s}\n{s}\n", .{ root_disk.file_system, root_disk.mounted_on });
}
