const std = @import("std");
const clap = @import("clap");

const io = std.io;
const debug = std.debug;
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const params = comptime clap.parseParamsComptime(
        \\-h, --help    Show help and exit
        \\-p, --print   Print and exit
        \\<name>...
        \\
    );

    const parsers = comptime .{
        .name = clap.parsers.string,
    };

    var diagnostic = clap.Diagnostic{};

    var res = clap.parse(clap.Help, &params, parsers, .{
        .diagnostic = &diagnostic,
        .allocator = gpa.allocator(),
    }) catch |err| {
        diagnostic.report(io.getStdErr().writer(), err) catch {};
        return err;
    };
    defer res.deinit();

    if (res.args.help == 1) {
        debug.print("6-clap: A simple program that prints its arguments\n\nUsage: clap ", .{});
        try clap.usage(std.io.getStdErr().writer(), clap.Help, &params);
        debug.print("\n\n", .{});
        try clap.help(
            std.io.getStdErr().writer(),
            clap.Help,
            &params,
            .{
                .description_on_new_line = false,
                .description_indent = 4,
                .spacing_between_parameters = 0,
            },
        );
        std.os.exit(0);
    }

    if (res.args.print == 1) {
        try stdout.print("Hello, {s}\n", .{res.positionals[0]});
    }
}
