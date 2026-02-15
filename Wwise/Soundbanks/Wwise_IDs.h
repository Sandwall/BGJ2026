/////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Audiokinetic Wwise generated include file. Do not edit.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __WWISE_IDS_H__
#define __WWISE_IDS_H__

#include <AK/SoundEngine/Common/AkTypes.h>

namespace AK
{
    namespace EVENTS
    {
        static const AkUniqueID GLOBAL_STARTGAME = 4026999643U;
        static const AkUniqueID PLAY_DX_PROFESSIONAL = 2538425816U;
        static const AkUniqueID PLAY_DX_QUIRKY = 508833130U;
        static const AkUniqueID PLAY_SFX_EMAILWHOOSH = 705681828U;
        static const AkUniqueID PLAY_SFX_FOOTSTEP = 57417936U;
        static const AkUniqueID PLAY_SFX_UIBACK = 4210552661U;
        static const AkUniqueID PLAY_SFX_UIHOVER = 641861106U;
        static const AkUniqueID PLAY_SFX_UIMOVE = 1440132459U;
        static const AkUniqueID PLAY_SFX_UISELECT = 808587124U;
        static const AkUniqueID STATE_MX_EXPLORATION = 3396848926U;
        static const AkUniqueID STATE_MX_GAMEPLAY = 3737599319U;
        static const AkUniqueID STATE_MX_MENU = 527025438U;
        static const AkUniqueID STATE_MX_PROFESSIONAL = 2355150710U;
        static const AkUniqueID STATE_MX_QUIRKY = 3265558508U;
        static const AkUniqueID SWITCH_SFX_CARPET = 2978681817U;
        static const AkUniqueID SWITCH_SFX_SQUELCH = 4053184047U;
        static const AkUniqueID SWITCH_SFX_STONE = 1583889895U;
    } // namespace EVENTS

    namespace STATES
    {
        namespace GAMEPLAY_STATES
        {
            static const AkUniqueID GROUP = 3572748042U;

            namespace STATE
            {
                static const AkUniqueID EXPLORATION = 2582085496U;
                static const AkUniqueID NONE = 748895195U;
                static const AkUniqueID PROFESSIONAL = 1728336744U;
                static const AkUniqueID QUIRKY = 3370484346U;
            } // namespace STATE
        } // namespace GAMEPLAY_STATES

        namespace MAIN_STATES
        {
            static const AkUniqueID GROUP = 1763937959U;

            namespace STATE
            {
                static const AkUniqueID GAMEPLAY = 89505537U;
                static const AkUniqueID MENU = 2607556080U;
                static const AkUniqueID NONE = 748895195U;
            } // namespace STATE
        } // namespace MAIN_STATES

    } // namespace STATES

    namespace SWITCHES
    {
        namespace FOOTSTEPS
        {
            static const AkUniqueID GROUP = 2385628198U;

            namespace SWITCH
            {
                static const AkUniqueID CARPET = 2412606308U;
                static const AkUniqueID SQUELCH = 3648590788U;
                static const AkUniqueID STONE = 1216965916U;
            } // namespace SWITCH
        } // namespace FOOTSTEPS

    } // namespace SWITCHES

    namespace BANKS
    {
        static const AkUniqueID INIT = 1355168291U;
        static const AkUniqueID MAINBANK = 2880737896U;
    } // namespace BANKS

    namespace BUSSES
    {
        static const AkUniqueID DX = 1836525785U;
        static const AkUniqueID MAIN_AUDIO_BUS = 2246998526U;
        static const AkUniqueID MX = 1685527054U;
        static const AkUniqueID SFX = 393239870U;
    } // namespace BUSSES

    namespace AUDIO_DEVICES
    {
        static const AkUniqueID NO_OUTPUT = 2317455096U;
        static const AkUniqueID SYSTEM = 3859886410U;
    } // namespace AUDIO_DEVICES

}// namespace AK

#endif // __WWISE_IDS_H__
