#include <amxmodx>
#include <amxmisc>
#include <gcljs>

#define PLUGIN "komi"
#define VERSION "0.1.0"
#define AUTHOR "komidan"
#define PLUGIN_SYMBOL "[K]"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)

	RegisterChatAndConsoleCmd("komi", "komi_menu", "func_menu", -1, "does nothing atm")
	register_concmd("komi_calc_noduck", "func_calc_noduck", -1, "<distance> <maxspeed> <airpath>")
	register_concmd("komi_pre_sim", "func_prestrafe_sim", -1, "<distance> <prestrafe> <airpath> <substituted-prestrafe>")
}

public func_calc_noduck(client)
{
	new Float:noduck_distance = read_argv_float(1)
	new Float:maxspeed = read_argv_float(2)
	new Float:airpath = read_argv_float(3)

	if (read_argv_float(1) == 0.0)
	{
		// if no arguments passed, print the usage
		console_print(client, "Usage: <distance> <maxspeed> <airpath>")

		return PLUGIN_HANDLED
	}

	/*
	* calculate estimated 'if' ducked distance
	* credits: Gamechaos
	* noduck distance + (maxspeed / (FPS) * airpath * 6)
	*/
	new Float:final_value_100 = noduck_distance + (maxspeed / 100.0 * airpath * 6)

	new print_message[64]
	formatex(print_message, charsmax(print_message), "%s DUCKED DISTANCE: %f", PLUGIN_SYMBOL, final_value_100)
	console_print(client, print_message)

	return PLUGIN_HANDLED
}

public func_prestrafe_sim(client)
{
	new Float:distance = read_argv_float(1)
	new Float:prestrafe = read_argv_float(2)
	new Float:airpath = read_argv_float(3)
	new Float:substituted_prestrafe = read_argv_float(4)

	if (read_argv_float(1) == 0.000000)
	{
		// if no arguments passed, print the usage
		console_print(client, "Usage: <distance> <prestrafe> <airpath> <substituted-prestrafe>")

		return PLUGIN_HANDLED
	}

	/*
	* calculate an estimated distance
	* credits: GameChaos
	* distance + (substituted prestrafe - prestrafe) * 0.732 / airpath
	*/
	new Float:estimated_distance = (distance + (substituted_prestrafe - prestrafe) * 0.732 / airpath)

	new print_message[32]
	formatex(print_message, charsmax(print_message), "%s ESTIMATED DISTANCE: %f", PLUGIN_SYMBOL, estimated_distance)
	console_print(client, print_message)	

	return PLUGIN_HANDLED
}

public func_menu(client)
{
	new menu_title[32]
	formatex(menu_title, charsmax(menu_title), "%s [v%s]", PLUGIN, VERSION)
	new menu = menu_create(menu_title, "menu_handler")

	menu_additem(menu, "Send Message to Hud", "", 0)

	menu_display(client, menu)

	return PLUGIN_HANDLED
}


public menu_handler(client, menu, item)
{
	if (item == 0)
	{
		set_hudmessage(.color2 = {255, 255, 255, 0}, .y = 0.75, .channel = 3)
		show_hudmessage(client, "Hello, it's your friend komidan.")
	}

	menu_destroy(menu)
	return PLUGIN_HANDLED
}

