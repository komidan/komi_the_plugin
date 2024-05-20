#include <amxmodx>
#include <amxmisc>
#pragma semicolon 1

#define PLUGIN "ko_utils"
#define VERSION "0.1.0" // (BIGUPDATE.SMALLUPDATE.BUGPATCHES)
#define AUTHOR "komidan"

public plugin_init()
{
    register_plugin(PLUGIN, VERSION, AUTHOR);

	register_concmd("ko_version", "func_version");
}

public func_version()
{
	console_print()
	return PLUGIN_HANDLED;
}

