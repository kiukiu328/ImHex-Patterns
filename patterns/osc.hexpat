
#pragma endian big

import std.io;
import std.mem;

struct String<auto N>
{
    char val[] [[name(N)]];
    padding[sizeof(val) % 4 == 0 ? 0 : 4 - (sizeof(val) % 4)];
};

struct Header
{
    char name[8];
    double timetag;
};

struct Argument<auto tag, auto N>
{
    if (tag == 'i')
    {
        s32 val [[name(N)]];
    }
    else if (tag == 'h')
    {
        s64 val [[name(N)]];
    }
    else if (tag == 'f')
    {
        float val [[name(N)]];
    }
    else if (tag == 'd')
    {
        double val [[name(N)]];
    }
    else if (tag == 's' || tag == 'S')
    {
        String<tag> val [[name(N)]];
    }
    else if (tag == 'b')
    {
        u32 size [[name(N)]];
        u8 data[] [[name(N)]];
        padding[sizeof(data) % 4 == 0 ? 0 : 4 - (sizeof(data) % 4)] [[name(N)]];
    }
    else if (tag == 'c')
    {
        u32 val [[name(N)]];
    }
    else if (tag == 'r')
    {
        u8 red [[name(N)]];
        u8 green [[name(N)]];
        u8 blue [[name(N)]];
        u8 alpha [[name(N)]];
    }
    else if (tag == 'm')
    {
        u8 portID [[name(N)]];
        u8 status [[name(N)]];
        u8 data1 [[name(N)]];
        u8 data2 [[name(N)]];
    }
    else if (tag == 'T' || tag == 'F' || tag == 'N' || tag == 'I')
    {
        // No data allocated
    }
    else
    {
        std::error(std::format("Unsupported type tag: {}", tag));
    }
};

struct Bundle
{
    u32 size;
    String<"address"> address[[inline]];
    String<"typetag"> typetag[[inline]];
    if (sizeof(typetag.val) > 2)
    {
        Argument<typetag.val[1], "args0"> args0[[inline]];
    }
    if (sizeof(typetag.val) > 3)
    {
        Argument<typetag.val[2], "args1"> args1[[inline]];
    }
    if (sizeof(typetag.val) > 4)
    {
        Argument<typetag.val[3], "args2"> args2[[inline]];
    }
    if (sizeof(typetag.val) > 5)
    {
        Argument<typetag.val[4], "args3"> args3[[inline]];
    }
    if (sizeof(typetag.val) > 6)
    {
        Argument<typetag.val[5], "args4"> args4[[inline]];
    }
    if (sizeof(typetag.val) > 7)
    {
        Argument<typetag.val[6], "args5"> args5[[inline]];
    }
    if (sizeof(typetag.val) > 8)
    {
        Argument<typetag.val[7], "args6"> args6[[inline]];
    }
    if (sizeof(typetag.val) > 9)
    {
        Argument<typetag.val[8], "args7"> args7[[inline]];
    }
    if (sizeof(typetag.val) > 10)
    {
        Argument<typetag.val[9], "args8"> args8[[inline]];
    }
    if (sizeof(typetag.val) > 11)
    {
        Argument<typetag.val[10], "args9"> args9[[inline]];
    }
    if (sizeof(typetag.val) > 12)
    {
        Argument<typetag.val[11], "args10"> args10[[inline]];
    }
    if (sizeof(typetag.val) > 13)
    {
        Argument<typetag.val[12], "args11"> args11[[inline]];
    }
};

Header header @ $;
Bundle bundle[while ($ < std::mem::size())] @ $;