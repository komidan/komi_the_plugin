#include <amxmodx>
#include <amxmisc>


#define PLUGIN "komiutils"
#define VERSION "0.1.0" // (BIGUPDATE.SMALLUPDATE.BUGPATCHES)
#define AUTHOR "komidan"
#define PLUGIN_SYMBOL "[K]"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)

	register_concmd("komi_version", "func_print_version", -1, "get plugin version")
	register_concmd("komi_calc_noduck", "func_calc_noduck", -1, "<distance> <maxspeed> <airpath>, calculate if ducked (don't use with stats that have stamina)")
}

public func_print_version(client)
{
	console_print(client, VERSION)
	return PLUGIN_HANDLED
}

public func_calc_noduck(client)
{
	// get args
	new Float:noduck_distance = read_argv_float(1)
	new Float:maxspeed = read_argv_float(2)
	new Float:airpath = read_argv_float(3)

	// calculate and assign final value to the ducked distance
	new Float:final_value_100 = noduck_distance + (maxspeed / 100.0 * airpath * 6)
	new print_message[256];
	formatex(print_message, charsmax(print_message), "%s DUCKED DISTANCE: %f", PLUGIN_SYMBOL, final_value_100)
	console_print(client, print_message)

	return PLUGIN_HANDLED
}

