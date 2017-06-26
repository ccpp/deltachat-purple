#include "deltachat-purple.h"

#define PURPLE_PLUGINS

#include <libpurple/notify.h>
#include <libpurple/plugin.h>
#include <libpurple/version.h>

static PurplePlugin *_plugin;
#define PLUGIN_ID "prpl-ccpp-deltachat"

static void init_plugin(PurplePlugin *plugin);
static gboolean plugin_load(PurplePlugin *plugin);
static GList *plugin_actions(PurplePlugin *plugin, gpointer context);
static void notify_configure_cb(PurplePluginAction *action);

static PurplePluginInfo info = {
    PURPLE_PLUGIN_MAGIC,
    PURPLE_MAJOR_VERSION,
    PURPLE_MINOR_VERSION,
    PURPLE_PLUGIN_PROTOCOL,
    NULL,
    0,
    NULL,
    PURPLE_PRIORITY_DEFAULT,

    PLUGIN_ID,
    "DeltaChat",
    "1.0",

    "Adds DeltaChat support",          
    "",          
    "Christian Plattner <ccpp@gmx.at>",                          
    "",     
    
    plugin_load,                   
    NULL,                          
    NULL,                          
                                   
    (PurplePluginUiInfo*) NULL,
    &prpl_info,
    (PurplePluginUiInfo*) NULL,
    plugin_actions,
    NULL,                          
    NULL,                          
    NULL,                          
    NULL                           
};
PURPLE_INIT_PLUGIN(deltachat, init_plugin, info)

static void                        
init_plugin(PurplePlugin *plugin)
{                                  
}

static gboolean
plugin_load(PurplePlugin *plugin) {

	_plugin = plugin;
	return TRUE;
}

static GList *
plugin_actions(PurplePlugin *plugin, gpointer context)
{
	GList *actions = NULL;

	actions = g_list_prepend(actions,
			purple_plugin_action_new("Configure", notify_configure_cb));

	return actions;
}

static void
notify_configure_cb(PurplePluginAction *action)
{
	purple_notify_message(_plugin, PURPLE_NOTIFY_MSG_INFO, "TODO",
	                 "TODO configure", NULL, NULL, NULL);
}

