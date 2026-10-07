// Keep original GBK identity for server Lua lookups. Only translate the wire
// display name to the character page supported by the current VNG font.
static const char* PhongThanRestoredNpcDisplayName(const char* original)
{
    static KTabFile names;
    static BOOL initialized = FALSE;
    static char display[32];
    if (!initialized)
    {
        names.Load("\\settings\\phongthan\\NpcDisplayNames.txt");
        initialized = TRUE;
    }
    display[0] = 0;
    if (original && original[0])
        names.GetString((char*)original, "DisplayName", "", display, sizeof(display));
    return display[0] ? display : NULL;
}
