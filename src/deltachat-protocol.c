#include "deltachat-purple.h"

#include <libpurple/prpl.h>
#include <libpurple/debug.h>

#define PLUGIN_ID "prpl-ccpp-deltachat"

static const char *deltachat_list_icon(PurpleAccount *account, PurpleBuddy *buddu);
static GList *deltachat_status_types(PurpleAccount *account);
static void deltachat_login(PurpleAccount *);
static void deltachat_close(PurpleConnection *);


PurplePluginProtocolInfo prpl_info = {
	OPT_PROTO_MAIL_CHECK | OPT_PROTO_IM_IMAGE,
	NULL,
	NULL,
	{},
	deltachat_list_icon,	// must be implemented
	NULL,
	NULL,	//deltachat_status_types,
	NULL,
	deltachat_status_types,	// must be implemented
	NULL,
	NULL,
	NULL,
	deltachat_login,
	deltachat_close,

	// ...

	.struct_size = sizeof(prpl_info),
};

static const char *deltachat_list_icon(PurpleAccount *account, PurpleBuddy *buddu)
{
	return NULL;
}

static GList *deltachat_status_types(PurpleAccount *account)
{
	GList *status_types = NULL;
	status_types = g_list_append(status_types, purple_status_type_new(PURPLE_STATUS_OFFLINE, NULL, NULL, FALSE));
	return status_types;
}

static void deltachat_login(PurpleAccount *account)
{
	purple_debug_info(PLUGIN_ID, "Logging into deltachat account %s", account->username);
}

static void deltachat_close(PurpleConnection *account)
{
	purple_debug_info(PLUGIN_ID, "Disconnection from deltachat");
}
