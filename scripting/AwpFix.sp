#include <dhooks>

public Plugin myinfo =
{
    name = "AwpFix",
    author = "xstage",
    description = "10 rounds in the clip",
    version = "1.0",
    url = "https://hlmod.ru/members/xstage.99505/"
};

DynamicHook hGetClip;

public void OnPluginStart()
{
    // GetMaxClip1
    hGetClip = DHookCreate(359, HookType_Entity, ReturnType_Int, ThisPointer_CBaseEntity);

    if (!hGetClip)
    {
        SetFailState("Failed to setup hook for GetMaxClip1");

        return;
    }

    DHookAddEntityListener(ListenType_Created, EntityCreate_Handler);
}

static void EntityCreate_Handler(int iEntity, const char[] szClassname)
{
    if (!strcmp(szClassname, "weapon_awp"))
    {
        hGetClip.HookEntity(Hook_Pre, iEntity, OnGetClip);
    }
}

static MRESReturn OnGetClip(int pThis, DHookReturn hReturn)
{
    hReturn.Value = 10;
    return MRES_Supercede;
}